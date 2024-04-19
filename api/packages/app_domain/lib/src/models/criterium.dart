import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'criterium.g.dart';

/// {@template criterium}
/// A model representing a criterium for a contest.
/// {@endtemplate}
@JsonSerializable()
class Criterium extends Equatable {
  /// Creates an instance of [Criterium].
  const Criterium({
    required this.order,
    required this.name,
    required this.description,
    this.maxScore = 5,
    this.percent = .0,
    this.subCriterias,
    this.minScore,
  })  : assert(order >= 0, 'Order must be greater than or equal to 0'),
        assert(maxScore >= 0, 'Max score must be greater than or equal to 0'),
        assert(percent >= 0, 'Percent must be greater than or equal to 0'),
        assert(percent <= 1, 'Percent must be less than or equal to 1');

  /// Converts a Criterium from a json map
  factory Criterium.fromJson(Map<String, dynamic> json) =>
      _$CriteriumFromJson(json);

  /// The order of the criterium
  final int order;

  /// The name of the criterium
  final String name;

  /// The description of the criterium
  final String description;

  /// The sub criteriums of the criterium
  final List<Criterium>? subCriterias;

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
    order: 0,
    name: '',
    description: '',
  );

  /// Returns true if this [Criterium] is empty
  bool get isEmpty => this == Criterium.empty;

  @override
  List<Object?> get props => [
        order,
        name,
        description,
        subCriterias,
        minScore,
        maxScore,
        percent,
      ];
}
