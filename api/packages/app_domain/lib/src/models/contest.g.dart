// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contest _$ContestFromJson(Map<String, dynamic> json) => Contest(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      criterias: (json['criterias'] as List<dynamic>)
          .map((e) => Criterium.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContestToJson(Contest instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'criterias': instance.criterias.map((e) => e.toJson()).toList(),
    };