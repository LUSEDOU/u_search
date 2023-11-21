// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Calification _$CalificationFromJson(Map<String, dynamic> json) {
  return _Calification.fromJson(json);
}

/// @nodoc
mixin _$Calification {
  /// The sub criteria of the Calification
  @JsonKey(required: true)
  SubCriteria get subCriteria => throw _privateConstructorUsedError;

  /// The id of the Calification
  @JsonKey(required: true)
  int? get id => throw _privateConstructorUsedError;

  /// The score of the Calification
  @JsonKey(required: true)
  double? get score => throw _privateConstructorUsedError;

  /// The comment of the Calification
  @JsonKey(required: true)
  String? get comment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CalificationCopyWith<Calification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalificationCopyWith<$Res> {
  factory $CalificationCopyWith(
          Calification value, $Res Function(Calification) then) =
      _$CalificationCopyWithImpl<$Res, Calification>;
  @useResult
  $Res call(
      {@JsonKey(required: true) SubCriteria subCriteria,
      @JsonKey(required: true) int? id,
      @JsonKey(required: true) double? score,
      @JsonKey(required: true) String? comment});

  $SubCriteriaCopyWith<$Res> get subCriteria;
}

/// @nodoc
class _$CalificationCopyWithImpl<$Res, $Val extends Calification>
    implements $CalificationCopyWith<$Res> {
  _$CalificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subCriteria = null,
    Object? id = freezed,
    Object? score = freezed,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      subCriteria: null == subCriteria
          ? _value.subCriteria
          : subCriteria // ignore: cast_nullable_to_non_nullable
              as SubCriteria,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SubCriteriaCopyWith<$Res> get subCriteria {
    return $SubCriteriaCopyWith<$Res>(_value.subCriteria, (value) {
      return _then(_value.copyWith(subCriteria: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CalificationImplCopyWith<$Res>
    implements $CalificationCopyWith<$Res> {
  factory _$$CalificationImplCopyWith(
          _$CalificationImpl value, $Res Function(_$CalificationImpl) then) =
      __$$CalificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(required: true) SubCriteria subCriteria,
      @JsonKey(required: true) int? id,
      @JsonKey(required: true) double? score,
      @JsonKey(required: true) String? comment});

  @override
  $SubCriteriaCopyWith<$Res> get subCriteria;
}

/// @nodoc
class __$$CalificationImplCopyWithImpl<$Res>
    extends _$CalificationCopyWithImpl<$Res, _$CalificationImpl>
    implements _$$CalificationImplCopyWith<$Res> {
  __$$CalificationImplCopyWithImpl(
      _$CalificationImpl _value, $Res Function(_$CalificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subCriteria = null,
    Object? id = freezed,
    Object? score = freezed,
    Object? comment = freezed,
  }) {
    return _then(_$CalificationImpl(
      subCriteria: null == subCriteria
          ? _value.subCriteria
          : subCriteria // ignore: cast_nullable_to_non_nullable
              as SubCriteria,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalificationImpl implements _Calification {
  const _$CalificationImpl(
      {@JsonKey(required: true) required this.subCriteria,
      @JsonKey(required: true) this.id,
      @JsonKey(required: true) this.score,
      @JsonKey(required: true) this.comment});

  factory _$CalificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalificationImplFromJson(json);

  /// The sub criteria of the Calification
  @override
  @JsonKey(required: true)
  final SubCriteria subCriteria;

  /// The id of the Calification
  @override
  @JsonKey(required: true)
  final int? id;

  /// The score of the Calification
  @override
  @JsonKey(required: true)
  final double? score;

  /// The comment of the Calification
  @override
  @JsonKey(required: true)
  final String? comment;

  @override
  String toString() {
    return 'Calification(subCriteria: $subCriteria, id: $id, score: $score, comment: $comment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalificationImpl &&
            (identical(other.subCriteria, subCriteria) ||
                other.subCriteria == subCriteria) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, subCriteria, id, score, comment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalificationImplCopyWith<_$CalificationImpl> get copyWith =>
      __$$CalificationImplCopyWithImpl<_$CalificationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalificationImplToJson(
      this,
    );
  }
}

abstract class _Calification implements Calification {
  const factory _Calification(
      {@JsonKey(required: true) required final SubCriteria subCriteria,
      @JsonKey(required: true) final int? id,
      @JsonKey(required: true) final double? score,
      @JsonKey(required: true) final String? comment}) = _$CalificationImpl;

  factory _Calification.fromJson(Map<String, dynamic> json) =
      _$CalificationImpl.fromJson;

  @override

  /// The sub criteria of the Calification
  @JsonKey(required: true)
  SubCriteria get subCriteria;
  @override

  /// The id of the Calification
  @JsonKey(required: true)
  int? get id;
  @override

  /// The score of the Calification
  @JsonKey(required: true)
  double? get score;
  @override

  /// The comment of the Calification
  @JsonKey(required: true)
  String? get comment;
  @override
  @JsonKey(ignore: true)
  _$$CalificationImplCopyWith<_$CalificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
