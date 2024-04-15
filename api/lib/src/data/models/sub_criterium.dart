import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sub_criterium.g.dart';

/// {@template sub_criterium}
/// A model representing a sub criteria for a criteria.
/// {@endtemplate}
@JsonSerializable()
class SubCriterium extends Equatable {
  /// Creates an instance of [SubCriterium].
  const SubCriterium({
    required this.id,
    required this.name,
    required this.description,
    this.maxScore = 5,
    this.percent = 1.0,
    this.minScore,
  });

  /// Converts a SubCriterium from a json map
  factory SubCriterium.fromJson(Map<String, dynamic> json) =>
      _$SubCriteriumFromJson(json);

  /// The id of the sub criterium
  final int id;

  /// The name of the sub criterium
  final String name;

  /// The description of the sub criterium
  final String description;

  /// The minimum score of the sub criterium
  final double? minScore;

  /// The maximum score of the sub criterium
  final double maxScore;

  /// The percent of the score
  final double percent;

  /// Converts a [SubCriterium] instance into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$SubCriteriumToJson(this);

  /// Creates a copy of [SubCriterium] with an optional parameter override.
  static const SubCriterium empty = SubCriterium(
    id: -1,
    name: '',
    description: '',
  );

  /// Returns true if this [SubCriterium] is empty
  bool get isEmpty => this == SubCriterium.empty;

  /// Returns true if this [SubCriterium] is created
  bool get isCreated => id != -1;

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
