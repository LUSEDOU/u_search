import 'package:data_repository/src/models/role.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'research.g.dart';

/// {@template research}
/// A model representing a research.
/// {@endtemplate}
@JsonSerializable()
class Research extends Equatable {

  /// Creates an instance of [Research].
  const Research({
    required this.researcher,
    required this.length,
    required this.title,
    required this.uuid,
    this.id,
  });

  /// Converts a Research from a json map
  factory Research.fromJson(Map<String, dynamic> json) =>
      _$ResearchFromJson(json);
  /// The id of the applicant
  final Role researcher;

  /// The length of the research in bytes
  final int length;

  /// The title of the research
  final String title;

  /// The uuid of the file
  final String uuid;

  /// The id of the research
  final int? id;

  /// Converts a [Research] instance into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$ResearchToJson(this);

  /// Creates a copy of [Research] with an optional parameter override.
  Research copyWith({
    Role? researcher,
    int? length,
    String? title,
    String? uuid,
    int? id,
  }) {
    return Research(
      researcher: researcher ?? this.researcher,
      length: length ?? this.length,
      title: title ?? this.title,
      uuid: uuid ?? this.uuid,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [researcher, length, title, uuid, id];
}

