import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:staff_frontend/util/dict_repository.dart';
import './api/api_rank_homographs.dart';


final rankHomographsRepository =
Provider<RankHomographsRepository>((ref) => RankHomographsRepository(ref));

class RankHomographsRepository {
  final Ref ref;

  RankHomographsRepository(this.ref);

  Future<List<ApiRankHomograph>> getRankHomographs(String word, {CancelToken? cancelToken}) async {

    final Response response = await ref.read(dictPod).get(
        '/staff/dict/rank_homographs/$word',
        cancelToken: cancelToken);

    ApiRankHomographs apiRankHomographs = ApiRankHomographs.fromJson(response.data);
    return apiRankHomographs.rankHomographs;
  }

  Future<String> updateRankHomographs(List<ApiRankHomograph> rankHomographs) async {
    final apiRankHomographs = ApiRankHomographs(rankHomographs: rankHomographs);

    final jsonData = apiRankHomographs.toJson();

    print('jsonData: $jsonData');


    final response = await ref.read(dictPod)
        .post('/staff/dict/rank_homographs', data: apiRankHomographs.toJson());

    return response.data;

  }
}
