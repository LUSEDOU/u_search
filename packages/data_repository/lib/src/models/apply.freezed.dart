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
  /// The contest of the apply
  @JsonKey(required: true)
  Contest get contest => throw _privateConstructorUsedError;

  /// The applicant of the apply
  @Deprecated('Use research instead')
  @JsonKey(required: true)
  String get url => throw _privateConstructorUsedError;

  /// The research of the apply
  @JsonKey(required: true)
  Research? get research => throw _privateConstructorUsedError;

  /// The id of the apply
  @JsonKey(required: true)
  int? get id => throw _privateConstructorUsedError;

  /// The evaluator
  User? get evaluator => throw _privateConstructorUsedError;

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
      {@JsonKey(required: true) Contest contest,
      @Deprecated('Use research instead') @JsonKey(required: true) String url,
      @JsonKey(required: true) Research? research,
      @JsonKey(required: true) int? id,
      User? evaluator,
      Review? review});

  $ContestCopyWith<$Res> get contest;
  $ResearchCopyWith<$Res>? get research;
  $UserCopyWith<$Res>? get evaluator;
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
    Object? contest = null,
    Object? url = null,
    Object? research = freezed,
    Object? id = freezed,
    Object? evaluator = freezed,
    Object? review = freezed,
  }) {
    return _then(_value.copyWith(
      contest: null == contest
          ? _value.contest
          : contest // ignore: cast_nullable_to_non_nullable
              as Contest,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      research: freezed == research
          ? _value.research
          : research // ignore: cast_nullable_to_non_nullable
              as Research?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      evaluator: freezed == evaluator
          ? _value.evaluator
          : evaluator // ignore: cast_nullable_to_non_nullable
              as User?,
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
  $ResearchCopyWith<$Res>? get research {
    if (_value.research == null) {
      return null;
    }

    return $ResearchCopyWith<$Res>(_value.research!, (value) {
      return _then(_value.copyWith(research: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get evaluator {
    if (_value.evaluator == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.evaluator!, (value) {
      return _then(_value.copyWith(evaluator: value) as $Val);
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
      {@JsonKey(required: true) Contest contest,
      @Deprecated('Use research instead') @JsonKey(required: true) String url,
      @JsonKey(required: true) Research? research,
      @JsonKey(required: true) int? id,
      User? evaluator,
      Review? review});

  @override
  $ContestCopyWith<$Res> get contest;
  @override
  $ResearchCopyWith<$Res>? get research;
  @override
  $UserCopyWith<$Res>? get evaluator;
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
    Object? contest = null,
    Object? url = null,
    Object? research = freezed,
    Object? id = freezed,
    Object? evaluator = freezed,
    Object? review = freezed,
  }) {
    return _then(_$ApplyImpl(
      contest: null == contest
          ? _value.contest
          : contest // ignore: cast_nullable_to_non_nullable
              as Contest,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      research: freezed == research
          ? _value.research
          : research // ignore: cast_nullable_to_non_nullable
              as Research?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      evaluator: freezed == evaluator
          ? _value.evaluator
          : evaluator // ignore: cast_nullable_to_non_nullable
              as User?,
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
      {@JsonKey(required: true) required this.contest,
      @Deprecated('Use research instead')
      @JsonKey(required: true)
      required this.url,
      @JsonKey(required: true) this.research,
      @JsonKey(required: true) this.id,
      this.evaluator,
      this.review});

  factory _$ApplyImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApplyImplFromJson(json);

  /// The contest of the apply
  @override
  @JsonKey(required: true)
  final Contest contest;

  /// The applicant of the apply
  @override
  @Deprecated('Use research instead')
  @JsonKey(required: true)
  final String url;

  /// The research of the apply
  @override
  @JsonKey(required: true)
  final Research? research;

  /// The id of the apply
  @override
  @JsonKey(required: true)
  final int? id;

  /// The evaluator
  @override
  final User? evaluator;

  /// An optional review of the apply
  @override
  final Review? review;

  @override
  String toString() {
    return 'Apply(contest: $contest, url: $url, research: $research, id: $id, evaluator: $evaluator, review: $review)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplyImpl &&
            (identical(other.contest, contest) || other.contest == contest) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.research, research) ||
                other.research == research) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.evaluator, evaluator) ||
                other.evaluator == evaluator) &&
            (identical(other.review, review) || other.review == review));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, contest, url, research, id, evaluator, review);

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
      {@JsonKey(required: true) required final Contest contest,
      @Deprecated('Use research instead')
      @JsonKey(required: true)
      required final String url,
      @JsonKey(required: true) final Research? research,
      @JsonKey(required: true) final int? id,
      final User? evaluator,
      final Review? review}) = _$ApplyImpl;

  factory _Apply.fromJson(Map<String, dynamic> json) = _$ApplyImpl.fromJson;

  @override

  /// The contest of the apply
  @JsonKey(required: true)
  Contest get contest;
  @override

  /// The applicant of the apply
  @Deprecated('Use research instead')
  @JsonKey(required: true)
  String get url;
  @override

  /// The research of the apply
  @JsonKey(required: true)
  Research? get research;
  @override

  /// The id of the apply
  @JsonKey(required: true)
  int? get id;
  @override

  /// The evaluator
  User? get evaluator;
  @override

  /// An optional review of the apply
  Review? get review;
  @override
  @JsonKey(ignore: true)
  _$$ApplyImplCopyWith<_$ApplyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
