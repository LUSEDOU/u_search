// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['email', 'name', 'id'],
  );
  return _$UserImpl(
    email: json['email'] as String,
    name: json['name'] as String,
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'id': instance.id,
    };
