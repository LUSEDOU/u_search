import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:u_search_api/api.dart';

part 'contest_response.g.dart';

/// {@template contest_response}
/// A response containing a list of contests.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class ContestResponse extends Equatable {
  /// {@macro contest_response}
  const ContestResponse({
    required this.contests,
  });

  /// Converts a [Map<String, dynamic>] into a [ContestResponse].
  factory ContestResponse.fromJson(Map<String, dynamic> json) =>
      _$ContestResponseFromJson(json);

  /// The list of contests.
  final List<Contest> contests;

  /// Converts a [ContestResponse] into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$ContestResponseToJson(this);

  @override
  List<Object> get props => [contests];
}
