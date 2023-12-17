import 'package:data_repository/src/models/sub_criteria.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'criteria.g.dart';

/// {@template criteria}
/// A model representing a criteria for a contest.
/// {@endtemplate}
@JsonSerializable()
class Criteria extends Equatable {
  /// Creates an instance of [Criteria].
  const Criteria({
    required this.id,
    this.name = '',
    this.description = '',
    this.subCriterias = const [],
    this.minScore,
    this.maxScore = 5,
    this.percent = 1.0,
  });

  /// Converts a Criteria from a json map
  factory Criteria.fromJson(Map<String, dynamic> json) =>
      _$CriteriaFromJson(json);

  /// The id of the criteria
  final int id;

  /// The name of the criteria
  final String name;

  /// The description of the criteria
  final String description;

  /// The sub criterias of the criteria
  final List<SubCriteria> subCriterias;

  /// The minimum score of the criteria
  final double? minScore;

  /// The maximum score of the criteria
  final double maxScore;

  /// The percent of the score
  final double percent;

  /// Converts a [Criteria] instance into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$CriteriaToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        subCriterias,
        minScore,
        maxScore,
        percent,
      ];
}
