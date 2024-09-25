import 'package:app_domain/app_domain.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'application.g.dart';

/// {@template application}
/// A model representing an application for a contest.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class Application extends Equatable {
  /// {@macro application}
  const Application({
    required this.contest,
    required this.research,
    this.id = -1,
    this.reviewer,
    this.review,
  });

  /// Converts a [Map<String, dynamic>] into a [Application] instance.
  factory Application.fromJson(Map<String, dynamic> json) =>
      _$ApplicationFromJson(json);

  /// The contest of the application
  final int contest;

  /// The research of the application
  final int research;

  /// The id of the application
  final int id;

  /// The evaluator
  final int? reviewer;

  /// An optional review of the application
  final int? review;

  /// Converts a [Application] instance into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$ApplicationToJson(this);

  /// Creates a copy of this [Application] but with the given fields replaced
  /// with the new values.
  Application copyWith({
    int? contest,
    int? research,
    int? id,
    int? reviewer,
    int? review,
  }) {
    return Application(
      contest: contest ?? this.contest,
      research: research ?? this.research,
      id: id ?? this.id,
      reviewer: reviewer ?? this.reviewer,
      review: review ?? this.review,
    );
  }

  /// Creates an empty [Application] instance.
  static const Application empty = Application(
    contest: -1,
    research: -1,
    id: -1,
  );

  /// Returns true if this [Application] is empty
  bool get isEmpty => this == Application.empty;

  /// Returns true if this [Application] is reviewed
  bool get isReviewed => review != null;

  /// Returns true if this [Application] is created
  bool get isCreated => id > 0;

  @override
  List<Object?> get props => [contest, research, id, reviewer, review];
}
