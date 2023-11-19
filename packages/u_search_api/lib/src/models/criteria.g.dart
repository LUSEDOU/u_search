// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'criteria.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CriteriaImpl _$$CriteriaImplFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'name', 'description'],
  );
  return _$CriteriaImpl(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$$CriteriaImplToJson(_$CriteriaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };

_$SubCriteriaImpl _$$SubCriteriaImplFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'name', 'description'],
  );
  return _$SubCriteriaImpl(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$$SubCriteriaImplToJson(_$SubCriteriaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
