import 'package:data_repository/data_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contest.g.dart';

/// {@template contest}
/// A model representing a contest for financial aid.
/// {@endtemplate}
@JsonSerializable()
class Contest {
  /// Creates an instance of [Contest].
  const Contest({
    required this.id,
    this.name = '',
    this.description = '',
    this.criterias = const [],
  });

  /// Converts a Contest from a json map
  factory Contest.fromJson(Map<String, dynamic> json) =>
      _$ContestFromJson(json);

  /// The id of the contest
  @JsonKey(required: true)
  final int id;

  /// The name of the contest
  @JsonKey(required: true)
  final String name;

  /// The description of the contest
  @JsonKey(required: true)
  final String description;

  /// The criterias of the contest
  @JsonKey(required: true)
  final List<Criteria> criterias;

  /// Converts a [Contest] instance into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$ContestToJson(this);
}

