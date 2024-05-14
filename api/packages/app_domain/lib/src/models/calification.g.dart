// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Calification _$CalificationFromJson(Map<String, dynamic> json) => Calification(
      order: json['order'] as int,
      score: (json['score'] as num).toDouble(),
      subCalifications: (json['subCalifications'] as List<dynamic>?)
          ?.map((e) => Calification.fromJson(e as Map<String, dynamic>))
          .toList(),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$CalificationToJson(Calification instance) =>
    <String, dynamic>{
      'order': instance.order,
      'score': instance.score,
      'comment': instance.comment,
      'subCalifications':
          instance.subCalifications?.map((e) => e.toJson()).toList(),
    };
