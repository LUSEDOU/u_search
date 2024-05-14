// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Apply _$ApplyFromJson(Map<String, dynamic> json) => Apply(
      contest: Contest.fromJson(json['contest'] as Map<String, dynamic>),
      research: Research.fromJson(json['research'] as Map<String, dynamic>),
      id: json['id'] as int? ?? -1,
      reviewer: json['reviewer'] == null
          ? null
          : User.fromJson(json['reviewer'] as Map<String, dynamic>),
      review: json['review'] == null
          ? null
          : Review.fromJson(json['review'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApplyToJson(Apply instance) => <String, dynamic>{
      'contest': instance.contest,
      'research': instance.research,
      'id': instance.id,
      'reviewer': instance.reviewer,
      'review': instance.review,
    };
