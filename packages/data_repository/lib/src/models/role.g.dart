// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoleImpl _$$RoleImplFromJson(Map<String, dynamic> json) => _$RoleImpl(
      id: json['id'] as int,
      type: $enumDecodeNullable(_$RoleTypeEnumMap, json['type']) ??
          RoleType.unknown,
    );

Map<String, dynamic> _$$RoleImplToJson(_$RoleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$RoleTypeEnumMap[instance.type]!,
    };

const _$RoleTypeEnumMap = {
  RoleType.researcher: 0,
  RoleType.reviewer: 1,
  RoleType.admin: 2,
  RoleType.unknown: 'unknown',
};
