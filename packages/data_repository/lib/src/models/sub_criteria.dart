import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sub_criteria.g.dart';

/// {@template sub_criteria}
/// A model representing a sub criteria for a criteria.
/// {@endtemplate}
@JsonSerializable()
class SubCriteria extends Equatable {
  /// Creates an instance of [SubCriteria].
  const SubCriteria({
    required this.id,
    this.name = '',
    this.description = '',
    this.maxScore = 5,
    this.percent = 1.0,
    this.minScore,
  });

  /// Converts a SubCriteria from a json map
  factory SubCriteria.fromJson(Map<String, dynamic> json) =>
      _$SubCriteriaFromJson(json);

  /// The id of the sub criteria
  final int id;

  /// The name of the sub criteria
  final String name;

  /// The description of the sub criteria
  final String description;

  /// The minimum score of the sub criteria
  final double? minScore;

  /// The maximum score of the sub criteria
  final double maxScore;

  /// The percent of the score
  final double percent;

  /// Converts a [SubCriteria] instance into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$SubCriteriaToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        minScore,
        maxScore,
        percent,
      ];
}
