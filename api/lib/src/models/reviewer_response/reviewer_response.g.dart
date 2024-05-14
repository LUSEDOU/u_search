// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviewer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewerResponse _$ReviewerResponseFromJson(Map<String, dynamic> json) =>
    ReviewerResponse(
      reviewers: (json['reviewers'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewerResponseToJson(ReviewerResponse instance) =>
    <String, dynamic>{
      'reviewers': instance.reviewers.map((e) => e.toJson()).toList(),
    };
