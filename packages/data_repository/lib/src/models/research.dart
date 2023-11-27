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
    /// The id of the research
    required String uuid,
    /// The name of the research
    required String url,
    /// The id of the applicant
    required int applicantId,
  }) = _Research;

  /// Converts a Research from a json map
  factory Research.fromJson(Map<String, dynamic> json) =>
      _$ResearchFromJson(json);
}
