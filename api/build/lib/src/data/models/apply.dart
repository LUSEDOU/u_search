import 'package:app_domain/app_domain.dart';
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
    this.id = -1,
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
  final int id;

  /// The evaluator
  final User? reviewer;

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
    User? reviewer,
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

  /// Creates an empty [Apply] instance.
  static const Apply empty = Apply(
    contest: Contest.empty,
    research: Research.empty,
  );

  /// Returns true if this [Apply] is empty
  bool get isEmpty => this == Apply.empty;

  /// Returns true if this [Apply] is reviewed
  bool get isReviewed => review != null;

  /// Returns true if this [Apply] is created
  bool get isCreated => id > 0;

  Application toApplication() => Application(
        id: id,
        contest: contest.id,
        research: research.id,
        reviewer: reviewer?.id,
        review: review?.id,
      );

  @override
  List<Object?> get props => [contest, research, id, reviewer, review];
}
