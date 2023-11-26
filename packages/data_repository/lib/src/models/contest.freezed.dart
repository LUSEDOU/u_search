// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Contest _$ContestFromJson(Map<String, dynamic> json) {
  return _Contest.fromJson(json);
}

/// @nodoc
mixin _$Contest {
  /// The id of the contest
  @JsonKey(required: true)
  int get id => throw _privateConstructorUsedError;

  /// The name of the contest
  @JsonKey(required: true)
  String get name => throw _privateConstructorUsedError;

  /// The description of the contest
  @JsonKey(required: true)
  String get description => throw _privateConstructorUsedError;

  /// The criterias of the contest
  @JsonKey(required: true)
  List<Criteria> get criterias => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContestCopyWith<Contest> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContestCopyWith<$Res> {
  factory $ContestCopyWith(Contest value, $Res Function(Contest) then) =
      _$ContestCopyWithImpl<$Res, Contest>;
  @useResult
  $Res call(
      {@JsonKey(required: true) int id,
      @JsonKey(required: true) String name,
      @JsonKey(required: true) String description,
      @JsonKey(required: true) List<Criteria> criterias});
}

/// @nodoc
class _$ContestCopyWithImpl<$Res, $Val extends Contest>
    implements $ContestCopyWith<$Res> {
  _$ContestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? criterias = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      criterias: null == criterias
          ? _value.criterias
          : criterias // ignore: cast_nullable_to_non_nullable
              as List<Criteria>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContestImplCopyWith<$Res> implements $ContestCopyWith<$Res> {
  factory _$$ContestImplCopyWith(
          _$ContestImpl value, $Res Function(_$ContestImpl) then) =
      __$$ContestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(required: true) int id,
      @JsonKey(required: true) String name,
      @JsonKey(required: true) String description,
      @JsonKey(required: true) List<Criteria> criterias});
}

/// @nodoc
class __$$ContestImplCopyWithImpl<$Res>
    extends _$ContestCopyWithImpl<$Res, _$ContestImpl>
    implements _$$ContestImplCopyWith<$Res> {
  __$$ContestImplCopyWithImpl(
      _$ContestImpl _value, $Res Function(_$ContestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? criterias = null,
  }) {
    return _then(_$ContestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      criterias: null == criterias
          ? _value._criterias
          : criterias // ignore: cast_nullable_to_non_nullable
              as List<Criteria>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContestImpl implements _Contest {
  const _$ContestImpl(
      {@JsonKey(required: true) required this.id,
      @JsonKey(required: true) required this.name,
      @JsonKey(required: true) required this.description,
      @JsonKey(required: true) required final List<Criteria> criterias})
      : _criterias = criterias;

  factory _$ContestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContestImplFromJson(json);

  /// The id of the contest
  @override
  @JsonKey(required: true)
  final int id;

  /// The name of the contest
  @override
  @JsonKey(required: true)
  final String name;

  /// The description of the contest
  @override
  @JsonKey(required: true)
  final String description;

  /// The criterias of the contest
  final List<Criteria> _criterias;

  /// The criterias of the contest
  @override
  @JsonKey(required: true)
  List<Criteria> get criterias {
    if (_criterias is EqualUnmodifiableListView) return _criterias;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_criterias);
  }

  @override
  String toString() {
    return 'Contest(id: $id, name: $name, description: $description, criterias: $criterias)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._criterias, _criterias));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description,
      const DeepCollectionEquality().hash(_criterias));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContestImplCopyWith<_$ContestImpl> get copyWith =>
      __$$ContestImplCopyWithImpl<_$ContestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContestImplToJson(
      this,
    );
  }
}

abstract class _Contest implements Contest {
  const factory _Contest(
          {@JsonKey(required: true) required final int id,
          @JsonKey(required: true) required final String name,
          @JsonKey(required: true) required final String description,
          @JsonKey(required: true) required final List<Criteria> criterias}) =
      _$ContestImpl;

  factory _Contest.fromJson(Map<String, dynamic> json) = _$ContestImpl.fromJson;

  @override

  /// The id of the contest
  @JsonKey(required: true)
  int get id;
  @override

  /// The name of the contest
  @JsonKey(required: true)
  String get name;
  @override

  /// The description of the contest
  @JsonKey(required: true)
  String get description;
  @override

  /// The criterias of the contest
  @JsonKey(required: true)
  List<Criteria> get criterias;
  @override
  @JsonKey(ignore: true)
  _$$ContestImplCopyWith<_$ContestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
