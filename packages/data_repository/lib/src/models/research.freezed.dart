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
  /// The id of the applicant
  int get applicantId => throw _privateConstructorUsedError;

  /// The length of the research in bytes
  int get length => throw _privateConstructorUsedError;

  /// The title of the research
  String get title => throw _privateConstructorUsedError;

  /// The uuid of the file
  @JsonKey(required: true)
  String? get uuid => throw _privateConstructorUsedError;

  /// The id of the research
  @JsonKey(required: true)
  int? get id => throw _privateConstructorUsedError;

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
  $Res call(
      {int applicantId,
      int length,
      String title,
      @JsonKey(required: true) String? uuid,
      @JsonKey(required: true) int? id});
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
    Object? applicantId = null,
    Object? length = null,
    Object? title = null,
    Object? uuid = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      applicantId: null == applicantId
          ? _value.applicantId
          : applicantId // ignore: cast_nullable_to_non_nullable
              as int,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
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
  $Res call(
      {int applicantId,
      int length,
      String title,
      @JsonKey(required: true) String? uuid,
      @JsonKey(required: true) int? id});
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
    Object? applicantId = null,
    Object? length = null,
    Object? title = null,
    Object? uuid = freezed,
    Object? id = freezed,
  }) {
    return _then(_$ResearchImpl(
      applicantId: null == applicantId
          ? _value.applicantId
          : applicantId // ignore: cast_nullable_to_non_nullable
              as int,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResearchImpl implements _Research {
  const _$ResearchImpl(
      {required this.applicantId,
      required this.length,
      required this.title,
      @JsonKey(required: true) this.uuid,
      @JsonKey(required: true) this.id});

  factory _$ResearchImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResearchImplFromJson(json);

  /// The id of the applicant
  @override
  final int applicantId;

  /// The length of the research in bytes
  @override
  final int length;

  /// The title of the research
  @override
  final String title;

  /// The uuid of the file
  @override
  @JsonKey(required: true)
  final String? uuid;

  /// The id of the research
  @override
  @JsonKey(required: true)
  final int? id;

  @override
  String toString() {
    return 'Research(applicantId: $applicantId, length: $length, title: $title, uuid: $uuid, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResearchImpl &&
            (identical(other.applicantId, applicantId) ||
                other.applicantId == applicantId) &&
            (identical(other.length, length) || other.length == length) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, applicantId, length, title, uuid, id);

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
      {required final int applicantId,
      required final int length,
      required final String title,
      @JsonKey(required: true) final String? uuid,
      @JsonKey(required: true) final int? id}) = _$ResearchImpl;

  factory _Research.fromJson(Map<String, dynamic> json) =
      _$ResearchImpl.fromJson;

  @override

  /// The id of the applicant
  int get applicantId;
  @override

  /// The length of the research in bytes
  int get length;
  @override

  /// The title of the research
  String get title;
  @override

  /// The uuid of the file
  @JsonKey(required: true)
  String? get uuid;
  @override

  /// The id of the research
  @JsonKey(required: true)
  int? get id;
  @override
  @JsonKey(ignore: true)
  _$$ResearchImplCopyWith<_$ResearchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
