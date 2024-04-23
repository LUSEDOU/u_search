import 'package:app_domain/app_domain.dart';
import 'package:app_domain/src/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calification.g.dart';

/// {@template calification}
/// A calification of a sub-criteria of a criteria of a contest.
/// {@endtemplate}
@JsonSerializable()
class Calification extends Equatable {
  /// Creates an instance of [Calification].
  const Calification({
    required this.order,
    required this.score,
    this.subCalifications,
    this.comment,
  });

  factory Calification.fromCriteria(Criterium criteria) {
    return Calification(
      order: criteria.order,
      score: -1,
      subCalifications:
          criteria.subCriterias?.map(Calification.fromCriteria).toList(),
    );
  }

  /// Converts a Calification from a json map
  factory Calification.fromJson(Map<String, dynamic> json) =>
      _$CalificationFromJson(json);

  /// The order of the Calification
  final int order;

  /// The score of the Calification
  final double score;

  /// The comment of the Calification
  final String? comment;

  /// The sub-califications of the Calification
  final List<Calification>? subCalifications;

  /// Converts a [Calification] instance into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$CalificationToJson(this);

  bool get isCreated => score != -1;

  Calification copyWith({
    int? order,
    double? score,
    String? comment,
    List<Calification>? subCalifications,
  }) {
    return Calification(
      order: order ?? this.order,
      score: score ?? this.score,
      comment: comment ?? this.comment,
      subCalifications: subCalifications ?? this.subCalifications,
    );
  }

  static const empty = Calification(order: -1, score: -1);

  @override
  List<Object?> get props => [order, score, comment, subCalifications];
}
