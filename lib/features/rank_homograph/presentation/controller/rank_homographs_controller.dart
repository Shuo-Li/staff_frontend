import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../data/rank_homographs_repository.dart';
import '../../data/api/api_rank_homographs.dart';

final searchedWordProvider = StateProvider<String>(
      (ref) => '',
);

final rankHomographsPod =
    FutureProvider<List<ApiRankHomograph>>((ref) async {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());

  final word = ref.watch(searchedWordProvider);

  if (word.trim() == '') {
    return [];
  }

  final apiRankHomographs =
      await ref.read(rankHomographsRepository).getRankHomographs(word, cancelToken: cancelToken);

  return apiRankHomographs;
});

/*
final rankHomographsPod =
    FutureProvider.family<List<ApiRankHomograph>, String>((ref, word) async {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());

  if (word.trim() == '') {
    return [];
  }

  final apiRankHomographs =
      await ref.read(rankHomographsRepository).getRankHomographs(word, cancelToken: cancelToken);

  return apiRankHomographs;
});
 */
