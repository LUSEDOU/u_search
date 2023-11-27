// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApplyImpl _$$ApplyImplFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['contest', 'id', 'research'],
  );
  return _$ApplyImpl(
    contest: Contest.fromJson(json['contest'] as Map<String, dynamic>),
    id: json['id'] as int?,
    research: json['research'] as String,
    review: json['review'] == null
        ? null
        : Review.fromJson(json['review'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$$ApplyImplToJson(_$ApplyImpl instance) =>
    <String, dynamic>{
      'contest': instance.contest,
      'id': instance.id,
      'research': instance.research,
      'review': instance.review,
    };
