// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contest_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContestResponse _$ContestResponseFromJson(Map<String, dynamic> json) =>
    ContestResponse(
      contests: (json['contests'] as List<dynamic>)
          .map((e) => Contest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContestResponseToJson(ContestResponse instance) =>
    <String, dynamic>{
      'contests': instance.contests.map((e) => e.toJson()).toList(),
    };
