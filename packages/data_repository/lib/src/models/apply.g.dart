// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApplyImpl _$$ApplyImplFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['contest', 'url', 'research', 'id'],
  );
  return _$ApplyImpl(
    contest: Contest.fromJson(json['contest'] as Map<String, dynamic>),
    url: json['url'] as String,
    research: json['research'] == null
        ? null
        : Research.fromJson(json['research'] as Map<String, dynamic>),
    id: json['id'] as int?,
    evaluator: json['evaluator'] == null
        ? null
        : User.fromJson(json['evaluator'] as Map<String, dynamic>),
    review: json['review'] == null
        ? null
        : Review.fromJson(json['review'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$$ApplyImplToJson(_$ApplyImpl instance) =>
    <String, dynamic>{
      'contest': instance.contest,
      'url': instance.url,
      'research': instance.research,
      'id': instance.id,
      'evaluator': instance.evaluator,
      'review': instance.review,
    };
