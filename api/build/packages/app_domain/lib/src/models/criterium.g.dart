// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'criterium.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Criterium _$CriteriumFromJson(Map<String, dynamic> json) => Criterium(
      order: json['order'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      maxScore: (json['maxScore'] as num?)?.toDouble() ?? 5,
      percent: (json['percent'] as num?)?.toDouble() ?? .0,
      subCriterias: (json['subCriterias'] as List<dynamic>?)
          ?.map((e) => Criterium.fromJson(e as Map<String, dynamic>))
          .toList(),
      minScore: (json['minScore'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CriteriumToJson(Criterium instance) => <String, dynamic>{
      'order': instance.order,
      'name': instance.name,
      'description': instance.description,
      'subCriterias': instance.subCriterias?.map((e) => e.toJson()).toList(),
      'minScore': instance.minScore,
      'maxScore': instance.maxScore,
      'percent': instance.percent,
    };
