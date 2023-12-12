import 'package:data_repository/data_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'apply.freezed.dart';
part 'apply.g.dart';

/// {@template apply}
/// A model representing an apply for a contest.
/// {@endtemplate}
@freezed
class Apply with _$Apply {
  /// {@macro apply}
  const factory Apply({
    /// The contest of the apply
    @JsonKey(required: true) required Contest contest,

    /// The research of the apply
    @JsonKey(required: true) Research? research,

    /// The id of the apply
    @JsonKey(required: true) int? id,

    /// The evaluator
    Role? reviewer,

    /// An optional review of the apply
    Review? review,
  }) = _Apply;

  /// Converts an Apply from a json map
  factory Apply.fromJson(Map<String, dynamic> json) => _$ApplyFromJson(json);
}
