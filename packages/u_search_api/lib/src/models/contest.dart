import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:u_search_api/src/models/models.dart';

part 'contest.freezed.dart';
part 'contest.g.dart';

/// {@template contest}
/// A model representing a contest for an financial aid.
/// {@endtemplate}
@freezed
class Contest with _$Contest {
  /// {@macro contest}
  const factory Contest({
    /// The id of the contest
    @JsonKey(required: true) required int id,

    /// The name of the contest
    @JsonKey(required: true) required String name,

    /// The description of the contest
    @JsonKey(required: true) required String description,

    /// The criterias of the contest
    @JsonKey(required: true) required List<Criteria> criterias,
  }) = _Contest;

  /// Converts a Contest from a json map
  factory Contest.fromJson(Map<String, dynamic> json) =>
      _$ContestFromJson(json);
}
