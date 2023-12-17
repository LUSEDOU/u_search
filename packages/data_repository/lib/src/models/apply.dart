import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'apply.g.dart';

@JsonSerializable()

/// {@template apply}
/// A model representing an apply for a contest.
/// {@endtemplate}
class Apply extends Equatable {
  /// {@macro apply}
  const Apply({
    required this.contest,
    required this.research,
    this.id,
    this.reviewer,
    this.review,
  });

  /// Converts a [Map<String, dynamic>] into a [Apply] instance.
  factory Apply.fromJson(Map<String, dynamic> json) => _$ApplyFromJson(json);

  /// The contest of the apply
  final Contest contest;

  /// The research of the apply
  final Research research;

  /// The id of the apply
  @JsonKey(required: true)
  final int? id;

  /// The evaluator
  final Role? reviewer;

  /// An optional review of the apply
  final Review? review;

  /// Converts a [Apply] instance into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$ApplyToJson(this);

  /// Creates a copy of this [Apply] but with the given fields replaced with
  /// the new values.
  Apply copyWith({
    Contest? contest,
    Research? research,
    int? id,
    Role? reviewer,
    Review? review,
  }) {
    return Apply(
      contest: contest ?? this.contest,
      research: research ?? this.research,
      id: id ?? this.id,
      reviewer: reviewer ?? this.reviewer,
      review: review ?? this.review,
    );
  }

  @override
  List<Object?> get props => [contest, research, id, reviewer, review];
}

