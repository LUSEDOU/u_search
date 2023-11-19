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
    @JsonKey(required: true) required String name,

    /// The description of the sub criteria
    @JsonKey(required: true) required String description,
  }) = _SubCriteria;

  /// Converts a SubCriteria from a json map
  factory SubCriteria.fromJson(Map<String, dynamic> json) =>
      _$SubCriteriaFromJson(json);
}
