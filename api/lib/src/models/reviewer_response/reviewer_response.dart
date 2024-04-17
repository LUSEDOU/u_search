import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:u_search_api/api.dart';

part 'reviewer_response.g.dart';

/// {@template reviewer_response}
/// A response containing a list of reviewers.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class ReviewerResponse extends Equatable {
  /// {@macro reviewer_response}
  const ReviewerResponse({
    required this.reviewers,
  });

  /// Converts a [Map<String, dynamic>] into a [ReviewerResponse].
  factory ReviewerResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewerResponseFromJson(json);

  /// The list of reviewers.
  final List<User> reviewers;

  /// Converts a [ReviewerResponse] into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$ReviewerResponseToJson(this);

  @override
  List<Object> get props => [reviewers];
}
