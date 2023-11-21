// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'criteria.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Criteria _$CriteriaFromJson(Map<String, dynamic> json) {
  return _Criteria.fromJson(json);
}

/// @nodoc
mixin _$Criteria {
  /// The id of the criteria
  @JsonKey(required: true)
  int get id => throw _privateConstructorUsedError;

  /// The name of the criteria
  @JsonKey(required: true)
  String get name => throw _privateConstructorUsedError;

  /// The description of the criteria
  @JsonKey(required: true)
  String get description => throw _privateConstructorUsedError;

  /// The sub criterias of the criteria
  @JsonKey(required: true)
  List<SubCriteria> get subCriterias => throw _privateConstructorUsedError;

  /// The minimum score of the criteria
  double? get minScore => throw _privateConstructorUsedError;

  /// The maximum score of the criteria
  @JsonKey(required: true)
  double get maxScore => throw _privateConstructorUsedError;

  /// The percent of the score
  @JsonKey(required: true)
  double get percent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CriteriaCopyWith<Criteria> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CriteriaCopyWith<$Res> {
  factory $CriteriaCopyWith(Criteria value, $Res Function(Criteria) then) =
      _$CriteriaCopyWithImpl<$Res, Criteria>;
  @useResult
  $Res call(
      {@JsonKey(required: true) int id,
      @JsonKey(required: true) String name,
      @JsonKey(required: true) String description,
      @JsonKey(required: true) List<SubCriteria> subCriterias,
      double? minScore,
      @JsonKey(required: true) double maxScore,
      @JsonKey(required: true) double percent});
}

/// @nodoc
class _$CriteriaCopyWithImpl<$Res, $Val extends Criteria>
    implements $CriteriaCopyWith<$Res> {
  _$CriteriaCopyWithImpl(this._value, this._then);

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
    Object? subCriterias = null,
    Object? minScore = freezed,
    Object? maxScore = null,
    Object? percent = null,
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
      subCriterias: null == subCriterias
          ? _value.subCriterias
          : subCriterias // ignore: cast_nullable_to_non_nullable
              as List<SubCriteria>,
      minScore: freezed == minScore
          ? _value.minScore
          : minScore // ignore: cast_nullable_to_non_nullable
              as double?,
      maxScore: null == maxScore
          ? _value.maxScore
          : maxScore // ignore: cast_nullable_to_non_nullable
              as double,
      percent: null == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CriteriaImplCopyWith<$Res>
    implements $CriteriaCopyWith<$Res> {
  factory _$$CriteriaImplCopyWith(
          _$CriteriaImpl value, $Res Function(_$CriteriaImpl) then) =
      __$$CriteriaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(required: true) int id,
      @JsonKey(required: true) String name,
      @JsonKey(required: true) String description,
      @JsonKey(required: true) List<SubCriteria> subCriterias,
      double? minScore,
      @JsonKey(required: true) double maxScore,
      @JsonKey(required: true) double percent});
}

/// @nodoc
class __$$CriteriaImplCopyWithImpl<$Res>
    extends _$CriteriaCopyWithImpl<$Res, _$CriteriaImpl>
    implements _$$CriteriaImplCopyWith<$Res> {
  __$$CriteriaImplCopyWithImpl(
      _$CriteriaImpl _value, $Res Function(_$CriteriaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? subCriterias = null,
    Object? minScore = freezed,
    Object? maxScore = null,
    Object? percent = null,
  }) {
    return _then(_$CriteriaImpl(
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
      subCriterias: null == subCriterias
          ? _value._subCriterias
          : subCriterias // ignore: cast_nullable_to_non_nullable
              as List<SubCriteria>,
      minScore: freezed == minScore
          ? _value.minScore
          : minScore // ignore: cast_nullable_to_non_nullable
              as double?,
      maxScore: null == maxScore
          ? _value.maxScore
          : maxScore // ignore: cast_nullable_to_non_nullable
              as double,
      percent: null == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CriteriaImpl implements _Criteria {
  const _$CriteriaImpl(
      {@JsonKey(required: true) required this.id,
      @JsonKey(required: true) required this.name,
      @JsonKey(required: true) required this.description,
      @JsonKey(required: true) final List<SubCriteria> subCriterias = const [],
      this.minScore,
      @JsonKey(required: true) this.maxScore = 5,
      @JsonKey(required: true) this.percent = 1.0})
      : _subCriterias = subCriterias;

  factory _$CriteriaImpl.fromJson(Map<String, dynamic> json) =>
      _$$CriteriaImplFromJson(json);

  /// The id of the criteria
  @override
  @JsonKey(required: true)
  final int id;

  /// The name of the criteria
  @override
  @JsonKey(required: true)
  final String name;

  /// The description of the criteria
  @override
  @JsonKey(required: true)
  final String description;

  /// The sub criterias of the criteria
  final List<SubCriteria> _subCriterias;

  /// The sub criterias of the criteria
  @override
  @JsonKey(required: true)
  List<SubCriteria> get subCriterias {
    if (_subCriterias is EqualUnmodifiableListView) return _subCriterias;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subCriterias);
  }

  /// The minimum score of the criteria
  @override
  final double? minScore;

  /// The maximum score of the criteria
  @override
  @JsonKey(required: true)
  final double maxScore;

  /// The percent of the score
  @override
  @JsonKey(required: true)
  final double percent;

  @override
  String toString() {
    return 'Criteria(id: $id, name: $name, description: $description, subCriterias: $subCriterias, minScore: $minScore, maxScore: $maxScore, percent: $percent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CriteriaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._subCriterias, _subCriterias) &&
            (identical(other.minScore, minScore) ||
                other.minScore == minScore) &&
            (identical(other.maxScore, maxScore) ||
                other.maxScore == maxScore) &&
            (identical(other.percent, percent) || other.percent == percent));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      const DeepCollectionEquality().hash(_subCriterias),
      minScore,
      maxScore,
      percent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CriteriaImplCopyWith<_$CriteriaImpl> get copyWith =>
      __$$CriteriaImplCopyWithImpl<_$CriteriaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CriteriaImplToJson(
      this,
    );
  }
}

abstract class _Criteria implements Criteria {
  const factory _Criteria(
      {@JsonKey(required: true) required final int id,
      @JsonKey(required: true) required final String name,
      @JsonKey(required: true) required final String description,
      @JsonKey(required: true) final List<SubCriteria> subCriterias,
      final double? minScore,
      @JsonKey(required: true) final double maxScore,
      @JsonKey(required: true) final double percent}) = _$CriteriaImpl;

  factory _Criteria.fromJson(Map<String, dynamic> json) =
      _$CriteriaImpl.fromJson;

  @override

  /// The id of the criteria
  @JsonKey(required: true)
  int get id;
  @override

  /// The name of the criteria
  @JsonKey(required: true)
  String get name;
  @override

  /// The description of the criteria
  @JsonKey(required: true)
  String get description;
  @override

  /// The sub criterias of the criteria
  @JsonKey(required: true)
  List<SubCriteria> get subCriterias;
  @override

  /// The minimum score of the criteria
  double? get minScore;
  @override

  /// The maximum score of the criteria
  @JsonKey(required: true)
  double get maxScore;
  @override

  /// The percent of the score
  @JsonKey(required: true)
  double get percent;
  @override
  @JsonKey(ignore: true)
  _$$CriteriaImplCopyWith<_$CriteriaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubCriteria _$SubCriteriaFromJson(Map<String, dynamic> json) {
  return _SubCriteria.fromJson(json);
}

/// @nodoc
mixin _$SubCriteria {
  /// The id of the sub criteria
  @JsonKey(required: true)
  int get id => throw _privateConstructorUsedError;

  /// The name of the sub criteria
  @JsonKey(required: true)
  String get name => throw _privateConstructorUsedError;

  /// The description of the sub criteria
  @JsonKey(required: true)
  String get description => throw _privateConstructorUsedError;

  /// The minimum score of the sub criteria
  double? get minScore => throw _privateConstructorUsedError;

  /// The maximum score of the sub criteria
  @JsonKey(required: true)
  double get maxScore => throw _privateConstructorUsedError;

  /// The percent of the score
  @JsonKey(required: true)
  double get percent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubCriteriaCopyWith<SubCriteria> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubCriteriaCopyWith<$Res> {
  factory $SubCriteriaCopyWith(
          SubCriteria value, $Res Function(SubCriteria) then) =
      _$SubCriteriaCopyWithImpl<$Res, SubCriteria>;
  @useResult
  $Res call(
      {@JsonKey(required: true) int id,
      @JsonKey(required: true) String name,
      @JsonKey(required: true) String description,
      double? minScore,
      @JsonKey(required: true) double maxScore,
      @JsonKey(required: true) double percent});
}

/// @nodoc
class _$SubCriteriaCopyWithImpl<$Res, $Val extends SubCriteria>
    implements $SubCriteriaCopyWith<$Res> {
  _$SubCriteriaCopyWithImpl(this._value, this._then);

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
    Object? minScore = freezed,
    Object? maxScore = null,
    Object? percent = null,
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
      minScore: freezed == minScore
          ? _value.minScore
          : minScore // ignore: cast_nullable_to_non_nullable
              as double?,
      maxScore: null == maxScore
          ? _value.maxScore
          : maxScore // ignore: cast_nullable_to_non_nullable
              as double,
      percent: null == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubCriteriaImplCopyWith<$Res>
    implements $SubCriteriaCopyWith<$Res> {
  factory _$$SubCriteriaImplCopyWith(
          _$SubCriteriaImpl value, $Res Function(_$SubCriteriaImpl) then) =
      __$$SubCriteriaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(required: true) int id,
      @JsonKey(required: true) String name,
      @JsonKey(required: true) String description,
      double? minScore,
      @JsonKey(required: true) double maxScore,
      @JsonKey(required: true) double percent});
}

/// @nodoc
class __$$SubCriteriaImplCopyWithImpl<$Res>
    extends _$SubCriteriaCopyWithImpl<$Res, _$SubCriteriaImpl>
    implements _$$SubCriteriaImplCopyWith<$Res> {
  __$$SubCriteriaImplCopyWithImpl(
      _$SubCriteriaImpl _value, $Res Function(_$SubCriteriaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? minScore = freezed,
    Object? maxScore = null,
    Object? percent = null,
  }) {
    return _then(_$SubCriteriaImpl(
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
      minScore: freezed == minScore
          ? _value.minScore
          : minScore // ignore: cast_nullable_to_non_nullable
              as double?,
      maxScore: null == maxScore
          ? _value.maxScore
          : maxScore // ignore: cast_nullable_to_non_nullable
              as double,
      percent: null == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubCriteriaImpl implements _SubCriteria {
  const _$SubCriteriaImpl(
      {@JsonKey(required: true) required this.id,
      @JsonKey(required: true) this.name = '',
      @JsonKey(required: true) this.description = '',
      this.minScore,
      @JsonKey(required: true) this.maxScore = 5,
      @JsonKey(required: true) this.percent = 1.0});

  factory _$SubCriteriaImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubCriteriaImplFromJson(json);

  /// The id of the sub criteria
  @override
  @JsonKey(required: true)
  final int id;

  /// The name of the sub criteria
  @override
  @JsonKey(required: true)
  final String name;

  /// The description of the sub criteria
  @override
  @JsonKey(required: true)
  final String description;

  /// The minimum score of the sub criteria
  @override
  final double? minScore;

  /// The maximum score of the sub criteria
  @override
  @JsonKey(required: true)
  final double maxScore;

  /// The percent of the score
  @override
  @JsonKey(required: true)
  final double percent;

  @override
  String toString() {
    return 'SubCriteria(id: $id, name: $name, description: $description, minScore: $minScore, maxScore: $maxScore, percent: $percent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubCriteriaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.minScore, minScore) ||
                other.minScore == minScore) &&
            (identical(other.maxScore, maxScore) ||
                other.maxScore == maxScore) &&
            (identical(other.percent, percent) || other.percent == percent));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, description, minScore, maxScore, percent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubCriteriaImplCopyWith<_$SubCriteriaImpl> get copyWith =>
      __$$SubCriteriaImplCopyWithImpl<_$SubCriteriaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubCriteriaImplToJson(
      this,
    );
  }
}

abstract class _SubCriteria implements SubCriteria {
  const factory _SubCriteria(
      {@JsonKey(required: true) required final int id,
      @JsonKey(required: true) final String name,
      @JsonKey(required: true) final String description,
      final double? minScore,
      @JsonKey(required: true) final double maxScore,
      @JsonKey(required: true) final double percent}) = _$SubCriteriaImpl;

  factory _SubCriteria.fromJson(Map<String, dynamic> json) =
      _$SubCriteriaImpl.fromJson;

  @override

  /// The id of the sub criteria
  @JsonKey(required: true)
  int get id;
  @override

  /// The name of the sub criteria
  @JsonKey(required: true)
  String get name;
  @override

  /// The description of the sub criteria
  @JsonKey(required: true)
  String get description;
  @override

  /// The minimum score of the sub criteria
  double? get minScore;
  @override

  /// The maximum score of the sub criteria
  @JsonKey(required: true)
  double get maxScore;
  @override

  /// The percent of the score
  @JsonKey(required: true)
  double get percent;
  @override
  @JsonKey(ignore: true)
  _$$SubCriteriaImplCopyWith<_$SubCriteriaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
