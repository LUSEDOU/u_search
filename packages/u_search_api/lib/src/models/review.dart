import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';
part 'review.g.dart';

/// {@template review}
/// A review of an apply to a contest, rates the apply in each criteria of the
/// contest.
/// {@endtemplate}
@freezed
class Review with _$Review {
  /// {@macro review}
  const factory Review({
    /// The id of the Review
    @JsonKey(required: true) required int? id,
  }) = _Review;

  /// Converts a Review from a json map
  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}
