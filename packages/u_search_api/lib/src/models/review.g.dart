// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'califications'],
  );
  return _$ReviewImpl(
    id: json['id'] as int?,
    califications: (json['califications'] as List<dynamic>?)
            ?.map((e) => Calification.fromJson(e as Map<String, dynamic>))
            .toList() ??
        const [],
    apply: json['apply'] == null
        ? null
        : Apply.fromJson(json['apply'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'califications': instance.califications,
      'apply': instance.apply,
    };
