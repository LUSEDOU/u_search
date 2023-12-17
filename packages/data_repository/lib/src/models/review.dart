import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.g.dart';

/// {@template review}
/// A review of an apply to a contest, rates the apply in each criteria of the
/// contest.
/// {@endtemplate}
@JsonSerializable()
class Review extends Equatable {
  /// {@macro review}
  const Review({
    required this.id,
    required this.califications,
  });

  /// The id of the review
  final int id;

  /// The califications of the review
  final List<Calification> califications;

  /// Converts a Review from a json map
  static Review fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  /// Creates an empty [Review] instance.
  static const Review empty = Review(
    id: -1,
    califications: [],
  );

  /// Returns true if this [Review] is empty
  bool get isEmpty => this == Review.empty;

  /// Returns true if this [Review] is created
  bool get isCreated => id != -1;

  /// Converts a [Review] instance into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  @override
  List<Object> get props => [id, califications];
}
