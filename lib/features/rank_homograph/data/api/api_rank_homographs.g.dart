// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_rank_homographs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiRankHomographs _$ApiRankHomographsFromJson(Map<String, dynamic> json) =>
    ApiRankHomographs(
      rankHomographs: (json['rankHomographs'] as List<dynamic>)
          .map((e) => ApiRankHomograph.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ApiRankHomographsToJson(ApiRankHomographs instance) =>
    <String, dynamic>{
      'rankHomographs': instance.rankHomographs,
    };

ApiRankHomograph _$ApiRankHomographFromJson(Map<String, dynamic> json) =>
    ApiRankHomograph(
      word: json['word'] as String,
      wordPosRank: json['wordPosRank'] as int,
      pos: json['pos'] as String,
      homographGroup: json['homographGroup'] as int,
      defNumber: json['defNumber'] as int,
      subDef: json['subDef'] as String,
      def: json['def'] as String,
    );

Map<String, dynamic> _$ApiRankHomographToJson(ApiRankHomograph instance) =>
    <String, dynamic>{
      'word': instance.word,
      'wordPosRank': instance.wordPosRank,
      'pos': instance.pos,
      'homographGroup': instance.homographGroup,
      'defNumber': instance.defNumber,
      'subDef': instance.subDef,
      'def': instance.def,
    };
