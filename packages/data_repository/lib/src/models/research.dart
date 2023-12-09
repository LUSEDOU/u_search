import 'package:freezed_annotation/freezed_annotation.dart';

part 'research.freezed.dart';
part 'research.g.dart';

/// {@template research}
/// A model representing a research.
/// {@endtemplate}
@freezed
class Research with _$Research {
  /// {@macro research}
  const factory Research({
    /// The id of the applicant
    required int applicantId,

    /// The length of the research in bytes
    required int length,

    /// The title of the research
    required String title,

    /// The uuid of the file
    @JsonKey(required: true) String? uuid,

    /// The id of the research
    @JsonKey(required: true) int? id,
  }) = _Research;

  /// Converts a Research from a json map
  factory Research.fromJson(Map<String, dynamic> json) =>
      _$ResearchFromJson(json);
}
