import 'package:app_domain/app_domain.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

/// {@template review}
/// A review of an apply to a contest, rates the apply in each criteria of the
/// contest.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class Review extends Equatable {

  /// {@macro review}
  const Review({
    required this.id,
    required this.calification,
    required this.criterias,
  });

  /// Converts a `Map<String, dynamic>` to a `Review` instance.
  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  /// The id of the review
  final int id;

  /// The calification of the review
  final Calification calification;

  /// The criterias of the review
  final List<Criterium> criterias;

  static const empty = Review(
    id: -1,
    calification: Calification.empty,
    criterias: [],
  );

  bool get isCreated => id != -1;

  /// Converts a [Review] instance into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  Review copyWith({
    int? id,
    Calification? calification,
    List<Criterium>? criterias,
  }) {
    return Review(
      id: id ?? this.id,
      calification: calification ?? this.calification,
      criterias: criterias ?? this.criterias,
    );
  }

  @override
  List<Object?> get props => [id, criterias, calification];
}
