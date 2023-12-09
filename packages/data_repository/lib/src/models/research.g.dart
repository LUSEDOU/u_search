// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'research.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResearchImpl _$$ResearchImplFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['uuid', 'id'],
  );
  return _$ResearchImpl(
    applicantId: json['applicantId'] as int,
    length: json['length'] as int,
    title: json['title'] as String,
    uuid: json['uuid'] as String?,
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$$ResearchImplToJson(_$ResearchImpl instance) =>
    <String, dynamic>{
      'applicantId': instance.applicantId,
      'length': instance.length,
      'title': instance.title,
      'uuid': instance.uuid,
      'id': instance.id,
    };
