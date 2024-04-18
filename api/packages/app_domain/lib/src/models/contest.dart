import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:app_domain_api/app_domain.dart';

part 'contest.g.dart';

/// {@template contest}
/// A model representing a contest for financial aid.
/// {@endtemplate}
@JsonSerializable()
class Contest extends Equatable {
  /// {@macro contest}
  const Contest({
    required this.id,
    required this.name,
    required this.description,
    required this.criterias,
  });

  /// Converts a Contest from a json map
  static Contest fromJson(Map<String, dynamic> json) => _$ContestFromJson(json);

  /// The id of the contest
  final int id;

  /// The name of the contest
  final String name;

  /// The description of the contest
  final String description;

  /// The criterias of the contest
  final List<Criterium> criterias;

  /// Converts a [Contest] instance into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$ContestToJson(this);

  /// Creates a copy of this [Contest] but with the given fields replaced with
  static const Contest empty = Contest(
    id: -1,
    name: '',
    description: '',
    criterias: [],
  );

  /// Returns true if this [Contest] is empty
  bool get isEmpty => this == Contest.empty;

  /// Returns true if this [Contest] is created
  bool get isCreated => id != -1;

  @override
  List<Object> get props => [id, name, description, criterias];
}
