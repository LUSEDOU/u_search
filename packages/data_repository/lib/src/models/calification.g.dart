// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CalificationImpl _$$CalificationImplFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['subCriteria', 'id', 'score', 'comment'],
  );
  return _$CalificationImpl(
    subCriteria:
        SubCriteria.fromJson(json['subCriteria'] as Map<String, dynamic>),
    id: json['id'] as int?,
    score: (json['score'] as num?)?.toDouble(),
    comment: json['comment'] as String?,
  );
}

Map<String, dynamic> _$$CalificationImplToJson(_$CalificationImpl instance) =>
    <String, dynamic>{
      'subCriteria': instance.subCriteria,
      'id': instance.id,
      'score': instance.score,
      'comment': instance.comment,
    };
