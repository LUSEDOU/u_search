// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'research.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Research _$ResearchFromJson(Map<String, dynamic> json) {
  return _Research.fromJson(json);
}

/// @nodoc
mixin _$Research {
  /// The id of the research
  String get uuid => throw _privateConstructorUsedError;

  /// The name of the research
  String get url => throw _privateConstructorUsedError;

  /// The id of the applicant
  int get applicantId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResearchCopyWith<Research> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResearchCopyWith<$Res> {
  factory $ResearchCopyWith(Research value, $Res Function(Research) then) =
      _$ResearchCopyWithImpl<$Res, Research>;
  @useResult
  $Res call({String uuid, String url, int applicantId});
}

/// @nodoc
class _$ResearchCopyWithImpl<$Res, $Val extends Research>
    implements $ResearchCopyWith<$Res> {
  _$ResearchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? url = null,
    Object? applicantId = null,
  }) {
    return _then(_value.copyWith(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      applicantId: null == applicantId
          ? _value.applicantId
          : applicantId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResearchImplCopyWith<$Res>
    implements $ResearchCopyWith<$Res> {
  factory _$$ResearchImplCopyWith(
          _$ResearchImpl value, $Res Function(_$ResearchImpl) then) =
      __$$ResearchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uuid, String url, int applicantId});
}

/// @nodoc
class __$$ResearchImplCopyWithImpl<$Res>
    extends _$ResearchCopyWithImpl<$Res, _$ResearchImpl>
    implements _$$ResearchImplCopyWith<$Res> {
  __$$ResearchImplCopyWithImpl(
      _$ResearchImpl _value, $Res Function(_$ResearchImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? url = null,
    Object? applicantId = null,
  }) {
    return _then(_$ResearchImpl(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      applicantId: null == applicantId
          ? _value.applicantId
          : applicantId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResearchImpl implements _Research {
  const _$ResearchImpl(
      {required this.uuid, required this.url, required this.applicantId});

  factory _$ResearchImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResearchImplFromJson(json);

  /// The id of the research
  @override
  final String uuid;

  /// The name of the research
  @override
  final String url;

  /// The id of the applicant
  @override
  final int applicantId;

  @override
  String toString() {
    return 'Research(uuid: $uuid, url: $url, applicantId: $applicantId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResearchImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.applicantId, applicantId) ||
                other.applicantId == applicantId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uuid, url, applicantId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResearchImplCopyWith<_$ResearchImpl> get copyWith =>
      __$$ResearchImplCopyWithImpl<_$ResearchImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResearchImplToJson(
      this,
    );
  }
}

abstract class _Research implements Research {
  const factory _Research(
      {required final String uuid,
      required final String url,
      required final int applicantId}) = _$ResearchImpl;

  factory _Research.fromJson(Map<String, dynamic> json) =
      _$ResearchImpl.fromJson;

  @override

  /// The id of the research
  String get uuid;
  @override

  /// The name of the research
  String get url;
  @override

  /// The id of the applicant
  int get applicantId;
  @override
  @JsonKey(ignore: true)
  _$$ResearchImplCopyWith<_$ResearchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
