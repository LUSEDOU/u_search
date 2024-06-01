// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'research.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Research _$ResearchFromJson(Map<String, dynamic> json) => Research(
      researcher: json['researcher'] as int,
      length: json['length'] as int,
      title: json['title'] as String,
      uuid: json['uuid'] as String,
      id: json['id'] as int? ?? -1,
    );

Map<String, dynamic> _$ResearchToJson(Research instance) => <String, dynamic>{
      'researcher': instance.researcher,
      'length': instance.length,
      'title': instance.title,
      'uuid': instance.uuid,
      'id': instance.id,
    };
