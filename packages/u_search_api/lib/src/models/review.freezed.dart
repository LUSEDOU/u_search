// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return _Review.fromJson(json);
}

/// @nodoc
mixin _$Review {
  /// The id of the Review
  @JsonKey(required: true)
  int? get id => throw _privateConstructorUsedError;

  /// List of califications of the review
  @JsonKey(required: true)
  List<Calification> get califications => throw _privateConstructorUsedError;

  /// The apply of the review
  Apply? get apply => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReviewCopyWith<Review> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewCopyWith<$Res> {
  factory $ReviewCopyWith(Review value, $Res Function(Review) then) =
      _$ReviewCopyWithImpl<$Res, Review>;
  @useResult
  $Res call(
      {@JsonKey(required: true) int? id,
      @JsonKey(required: true) List<Calification> califications,
      Apply? apply});

  $ApplyCopyWith<$Res>? get apply;
}

/// @nodoc
class _$ReviewCopyWithImpl<$Res, $Val extends Review>
    implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? califications = null,
    Object? apply = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      califications: null == califications
          ? _value.califications
          : califications // ignore: cast_nullable_to_non_nullable
              as List<Calification>,
      apply: freezed == apply
          ? _value.apply
          : apply // ignore: cast_nullable_to_non_nullable
              as Apply?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ApplyCopyWith<$Res>? get apply {
    if (_value.apply == null) {
      return null;
    }

    return $ApplyCopyWith<$Res>(_value.apply!, (value) {
      return _then(_value.copyWith(apply: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReviewImplCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$$ReviewImplCopyWith(
          _$ReviewImpl value, $Res Function(_$ReviewImpl) then) =
      __$$ReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(required: true) int? id,
      @JsonKey(required: true) List<Calification> califications,
      Apply? apply});

  @override
  $ApplyCopyWith<$Res>? get apply;
}

/// @nodoc
class __$$ReviewImplCopyWithImpl<$Res>
    extends _$ReviewCopyWithImpl<$Res, _$ReviewImpl>
    implements _$$ReviewImplCopyWith<$Res> {
  __$$ReviewImplCopyWithImpl(
      _$ReviewImpl _value, $Res Function(_$ReviewImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? califications = null,
    Object? apply = freezed,
  }) {
    return _then(_$ReviewImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      califications: null == califications
          ? _value._califications
          : califications // ignore: cast_nullable_to_non_nullable
              as List<Calification>,
      apply: freezed == apply
          ? _value.apply
          : apply // ignore: cast_nullable_to_non_nullable
              as Apply?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewImpl implements _Review {
  const _$ReviewImpl(
      {@JsonKey(required: true) this.id,
      @JsonKey(required: true)
      final List<Calification> califications = const [],
      this.apply})
      : _califications = califications;

  factory _$ReviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewImplFromJson(json);

  /// The id of the Review
  @override
  @JsonKey(required: true)
  final int? id;

  /// List of califications of the review
  final List<Calification> _califications;

  /// List of califications of the review
  @override
  @JsonKey(required: true)
  List<Calification> get califications {
    if (_califications is EqualUnmodifiableListView) return _califications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_califications);
  }

  /// The apply of the review
  @override
  final Apply? apply;

  @override
  String toString() {
    return 'Review(id: $id, califications: $califications, apply: $apply)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._califications, _califications) &&
            (identical(other.apply, apply) || other.apply == apply));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id,
      const DeepCollectionEquality().hash(_califications), apply);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
      __$$ReviewImplCopyWithImpl<_$ReviewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewImplToJson(
      this,
    );
  }
}

abstract class _Review implements Review {
  const factory _Review(
      {@JsonKey(required: true) final int? id,
      @JsonKey(required: true) final List<Calification> califications,
      final Apply? apply}) = _$ReviewImpl;

  factory _Review.fromJson(Map<String, dynamic> json) = _$ReviewImpl.fromJson;

  @override

  /// The id of the Review
  @JsonKey(required: true)
  int? get id;
  @override

  /// List of califications of the review
  @JsonKey(required: true)
  List<Calification> get califications;
  @override

  /// The apply of the review
  Apply? get apply;
  @override
  @JsonKey(ignore: true)
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
