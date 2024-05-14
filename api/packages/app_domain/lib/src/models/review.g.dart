// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: json['id'] as int,
      calification:
          Calification.fromJson(json['calification'] as Map<String, dynamic>),
      criterias: (json['criterias'] as List<dynamic>)
          .map((e) => Criterium.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'calification': instance.calification.toJson(),
      'criterias': instance.criterias.map((e) => e.toJson()).toList(),
    };
