import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:u_search_api/src/models/models.dart';

part 'calification.freezed.dart';
part 'calification.g.dart';

/// {@template calification}
/// A calification of a sub criteria of a criteria of a contest.
/// {@endtemplate}
@freezed
class Calification with _$Calification {
  /// {@macro calification}
  const factory Calification({
    /// The sub criteria of the Calification
    @JsonKey(required: true) required SubCriteria subCriteria,

    /// The id of the Calification
    @JsonKey(required: true) int? id,

    /// The score of the Calification
    @JsonKey(required: true) double? score,

    /// The comment of the Calification
    @JsonKey(required: true) String? comment,
  }) = _Calification;

  /// Converts a Calification from a json map
  factory Calification.fromJson(Map<String, dynamic> json) =>
      _$CalificationFromJson(json);
}
