import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:u_search_api/api.dart';

part 'review.g.dart';

/// {@template review}
/// A review of an apply to a contest, rates the apply in each criteria of the
/// contest.
/// {@endtemplate}
@JsonSerializable()
class Review extends Equatable {
  /// {@macro review}
  const Review({
    required this.califications,
    required this.criterias,
    this.id,
  });

  /// The id of the review
  final int? id;

  /// The schema of the review
  final List<Criterium> criterias;

  /// The califications of the review
  final List<Calification> califications;

  /// Converts a Review from a json map
  static Review fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  /// Creates an empty [Review] instance.
  static const Review empty = Review(
    califications: [],
    criterias: [],
  );

  /// Returns true if this [Review] is empty
  bool get isEmpty => this == Review.empty;

  /// Returns true if this [Review] is created
  bool get isCreated => id == null;

  /// Converts a [Review] instance into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  /// Returns a copy of this [Review] instance.
  Review copyWith({
    int? id,
    List<Calification>? califications,
    List<Criterium>? criterias,
  }) {
    return Review(
      id: id ?? this.id,
      califications: califications ?? this.califications,
      criterias: criterias ?? this.criterias,
    );
  }

  @override
  List<Object?> get props => [id, califications, criterias];
}
