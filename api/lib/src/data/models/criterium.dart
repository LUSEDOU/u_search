import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:u_search_api/api.dart';

part 'criterium.g.dart';

/// {@template criterium}
/// A model representing a criterium for a contest.
/// {@endtemplate}
@JsonSerializable()
class Criterium extends Equatable {
  /// Creates an instance of [Criterium].
  const Criterium({
    required this.id,
    required this.name,
    required this.description,
    required this.subCriterias,
    this.minScore,
    this.maxScore = 5,
    this.percent = 1.0,
  });

  /// Converts a Criterium from a json map
  factory Criterium.fromJson(Map<String, dynamic> json) =>
      _$CriteriumFromJson(json);

  /// The id of the criterium
  final int id;

  /// The name of the criterium
  final String name;

  /// The description of the criterium
  final String description;

  /// The sub criteriums of the criterium
  final List<SubCriterium> subCriterias;

  /// The minimum score of the criterium
  final double? minScore;

  /// The maximum score of the criterium
  final double maxScore;

  /// The percent of the score
  final double percent;

  /// Converts a [Criterium] instance into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$CriteriumToJson(this);

  /// Creates a copy of [Criterium] with an optional parameter override.
  static const Criterium empty = Criterium(
    id: -1,
    name: '',
    description: '',
    subCriterias: [],
  );

  /// Returns true if this [Criterium] is empty
  bool get isEmpty => this == Criterium.empty;

  /// Returns true if this [Criterium] is created
  bool get isCreated => id != -1;

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
