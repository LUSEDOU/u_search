import 'package:data_repository/data_repository.dart';
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
    required this.subCriteria,
    required this.score,
    required this.comment,
    required this.id,
  });

  /// Converts a Calification from a json map
  factory Calification.fromJson(Map<String, dynamic> json) =>
      _$CalificationFromJson(json);

  /// The sub-criteria of the Calification
  final SubCriteria subCriteria;

  /// The id of the Calification
  final int id;

  /// The score of the Calification
  final double score;

  /// The comment of the Calification
  final String comment;

  /// Converts a [Calification] instance into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$CalificationToJson(this);

  @override
  List<Object?> get props => [subCriteria, id, score, comment];
}
