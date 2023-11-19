// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContestImpl _$$ContestImplFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'name', 'description', 'criterias'],
  );
  return _$ContestImpl(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    criterias: (json['criterias'] as List<dynamic>)
        .map((e) => Criteria.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$$ContestImplToJson(_$ContestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'criterias': instance.criterias,
    };
