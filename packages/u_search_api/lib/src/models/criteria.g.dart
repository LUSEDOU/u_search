// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'criteria.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CriteriaImpl _$$CriteriaImplFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'name',
      'description',
      'subCriterias',
      'maxScore',
      'percent'
    ],
  );
  return _$CriteriaImpl(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    subCriterias: (json['subCriterias'] as List<dynamic>?)
            ?.map((e) => SubCriteria.fromJson(e as Map<String, dynamic>))
            .toList() ??
        const [],
    minScore: (json['minScore'] as num?)?.toDouble(),
    maxScore: (json['maxScore'] as num?)?.toDouble() ?? 5,
    percent: (json['percent'] as num?)?.toDouble() ?? 1.0,
  );
}

Map<String, dynamic> _$$CriteriaImplToJson(_$CriteriaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'subCriterias': instance.subCriterias,
      'minScore': instance.minScore,
      'maxScore': instance.maxScore,
      'percent': instance.percent,
    };

_$SubCriteriaImpl _$$SubCriteriaImplFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'name', 'description', 'maxScore', 'percent'],
  );
  return _$SubCriteriaImpl(
    id: json['id'] as int,
    name: json['name'] as String? ?? '',
    description: json['description'] as String? ?? '',
    minScore: (json['minScore'] as num?)?.toDouble(),
    maxScore: (json['maxScore'] as num?)?.toDouble() ?? 5,
    percent: (json['percent'] as num?)?.toDouble() ?? 1.0,
  );
}

Map<String, dynamic> _$$SubCriteriaImplToJson(_$SubCriteriaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'minScore': instance.minScore,
      'maxScore': instance.maxScore,
      'percent': instance.percent,
    };
