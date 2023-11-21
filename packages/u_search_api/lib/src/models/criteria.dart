import 'package:freezed_annotation/freezed_annotation.dart';

part 'criteria.freezed.dart';
part 'criteria.g.dart';

/// {@template criteria}
/// A model representing a criteria for a contest.
/// {@endtemplate}
@freezed
class Criteria with _$Criteria {
  /// {@macro criteria}
  const factory Criteria({
    /// The id of the criteria
    @JsonKey(required: true) required int id,

    /// The name of the criteria
    @JsonKey(required: true) required String name,

    /// The description of the criteria
    @JsonKey(required: true) required String description,

    /// The sub criterias of the criteria
    @JsonKey(required: true) @Default([]) List<SubCriteria> subCriterias,

    /// The minimum score of the criteria
    double? minScore,

    /// The maximum score of the criteria
    @JsonKey(required: true) @Default(5) double maxScore,

    /// The percent of the score
    @JsonKey(required: true) @Default(1.0) double percent,
  }) = _Criteria;

  /// Converts a Criteria from a json map
  factory Criteria.fromJson(Map<String, dynamic> json) =>
      _$CriteriaFromJson(json);
}

/// {@template sub_criteria}
/// A model representing a sub criteria for a criteria.
/// {@endtemplate}
@freezed
class SubCriteria with _$SubCriteria {
  /// {@macro sub_criteria}
  const factory SubCriteria({
    /// The id of the sub criteria
    @JsonKey(required: true) required int id,

    /// The name of the sub criteria
    @JsonKey(required: true) @Default('') String name,

    /// The description of the sub criteria
    @JsonKey(required: true) @Default('') String description,

    /// The minimum score of the sub criteria
    double? minScore,

    /// The maximum score of the sub criteria
    @JsonKey(required: true) @Default(5) double maxScore,

    /// The percent of the score
    @JsonKey(required: true) @Default(1.0) double percent,
  }) = _SubCriteria;

  /// Converts a SubCriteria from a json map
  factory SubCriteria.fromJson(Map<String, dynamic> json) =>
      _$SubCriteriaFromJson(json);
}
