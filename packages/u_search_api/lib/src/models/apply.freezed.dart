// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apply.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Apply _$ApplyFromJson(Map<String, dynamic> json) {
  return _Apply.fromJson(json);
}

/// @nodoc
mixin _$Apply {
  /// The id of the apply
  @JsonKey(required: true)
  int? get id => throw _privateConstructorUsedError;

  /// The contest of the apply
  @JsonKey(required: true)
  Contest get contest => throw _privateConstructorUsedError;

  /// An optional review of the apply
  Review? get review => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApplyCopyWith<Apply> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplyCopyWith<$Res> {
  factory $ApplyCopyWith(Apply value, $Res Function(Apply) then) =
      _$ApplyCopyWithImpl<$Res, Apply>;
  @useResult
  $Res call(
      {@JsonKey(required: true) int? id,
      @JsonKey(required: true) Contest contest,
      Review? review});

  $ContestCopyWith<$Res> get contest;
  $ReviewCopyWith<$Res>? get review;
}

/// @nodoc
class _$ApplyCopyWithImpl<$Res, $Val extends Apply>
    implements $ApplyCopyWith<$Res> {
  _$ApplyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? contest = null,
    Object? review = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      contest: null == contest
          ? _value.contest
          : contest // ignore: cast_nullable_to_non_nullable
              as Contest,
      review: freezed == review
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as Review?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ContestCopyWith<$Res> get contest {
    return $ContestCopyWith<$Res>(_value.contest, (value) {
      return _then(_value.copyWith(contest: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ReviewCopyWith<$Res>? get review {
    if (_value.review == null) {
      return null;
    }

    return $ReviewCopyWith<$Res>(_value.review!, (value) {
      return _then(_value.copyWith(review: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApplyImplCopyWith<$Res> implements $ApplyCopyWith<$Res> {
  factory _$$ApplyImplCopyWith(
          _$ApplyImpl value, $Res Function(_$ApplyImpl) then) =
      __$$ApplyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(required: true) int? id,
      @JsonKey(required: true) Contest contest,
      Review? review});

  @override
  $ContestCopyWith<$Res> get contest;
  @override
  $ReviewCopyWith<$Res>? get review;
}

/// @nodoc
class __$$ApplyImplCopyWithImpl<$Res>
    extends _$ApplyCopyWithImpl<$Res, _$ApplyImpl>
    implements _$$ApplyImplCopyWith<$Res> {
  __$$ApplyImplCopyWithImpl(
      _$ApplyImpl _value, $Res Function(_$ApplyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? contest = null,
    Object? review = freezed,
  }) {
    return _then(_$ApplyImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      contest: null == contest
          ? _value.contest
          : contest // ignore: cast_nullable_to_non_nullable
              as Contest,
      review: freezed == review
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as Review?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApplyImpl implements _Apply {
  const _$ApplyImpl(
      {@JsonKey(required: true) required this.id,
      @JsonKey(required: true) required this.contest,
      this.review});

  factory _$ApplyImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApplyImplFromJson(json);

  /// The id of the apply
  @override
  @JsonKey(required: true)
  final int? id;

  /// The contest of the apply
  @override
  @JsonKey(required: true)
  final Contest contest;

  /// An optional review of the apply
  @override
  final Review? review;

  @override
  String toString() {
    return 'Apply(id: $id, contest: $contest, review: $review)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.contest, contest) || other.contest == contest) &&
            (identical(other.review, review) || other.review == review));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, contest, review);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplyImplCopyWith<_$ApplyImpl> get copyWith =>
      __$$ApplyImplCopyWithImpl<_$ApplyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplyImplToJson(
      this,
    );
  }
}

abstract class _Apply implements Apply {
  const factory _Apply(
      {@JsonKey(required: true) required final int? id,
      @JsonKey(required: true) required final Contest contest,
      final Review? review}) = _$ApplyImpl;

  factory _Apply.fromJson(Map<String, dynamic> json) = _$ApplyImpl.fromJson;

  @override

  /// The id of the apply
  @JsonKey(required: true)
  int? get id;
  @override

  /// The contest of the apply
  @JsonKey(required: true)
  Contest get contest;
  @override

  /// An optional review of the apply
  Review? get review;
  @override
  @JsonKey(ignore: true)
  _$$ApplyImplCopyWith<_$ApplyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
