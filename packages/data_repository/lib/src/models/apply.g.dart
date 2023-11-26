// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApplyImpl _$$ApplyImplFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'contest'],
  );
  return _$ApplyImpl(
    id: json['id'] as int?,
    contest: Contest.fromJson(json['contest'] as Map<String, dynamic>),
    review: json['review'] == null
        ? null
        : Review.fromJson(json['review'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$$ApplyImplToJson(_$ApplyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contest': instance.contest,
      'review': instance.review,
    };
