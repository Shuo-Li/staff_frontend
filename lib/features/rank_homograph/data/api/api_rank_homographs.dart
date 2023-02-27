import 'package:json_annotation/json_annotation.dart';

part 'api_rank_homographs.g.dart';

// A lemma has a list of homographs (more precisely, a map of homographById)
// A homograph is a group of definitions

@JsonSerializable()
class ApiRankHomographs {
  ApiRankHomographs({
    required this.rankHomographs,
  });

  final List<ApiRankHomograph> rankHomographs;

  factory ApiRankHomographs.fromJson(Map<String, dynamic> json) => _$ApiRankHomographsFromJson(json);

  Map<String, dynamic> toJson() => _$ApiRankHomographsToJson(this);
}

@JsonSerializable()
class ApiRankHomograph {
  ApiRankHomograph({
    required this.word,
    required this.wordPosRank,
    required this.pos,
    required this.homographGroup,
    required this.defNumber,
    required this.subDef,
    required this.def,
});

  final String word;

  final int wordPosRank;

  final String pos;

  final int homographGroup;

  final int defNumber;

  final String subDef;

  final String def;

  factory ApiRankHomograph.fromJson(Map<String, dynamic> json) => _$ApiRankHomographFromJson(json);

  Map<String, dynamic> toJson() => _$ApiRankHomographToJson(this);
}