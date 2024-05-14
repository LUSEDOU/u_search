// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Application _$ApplicationFromJson(Map<String, dynamic> json) => Application(
      contest: json['contest'] as int,
      research: json['research'] as int,
      id: json['id'] as int? ?? -1,
      reviewer: json['reviewer'] as int?,
      review: json['review'] as int?,
    );

Map<String, dynamic> _$ApplicationToJson(Application instance) =>
    <String, dynamic>{
      'contest': instance.contest,
      'research': instance.research,
      'id': instance.id,
      'reviewer': instance.reviewer,
      'review': instance.review,
    };
