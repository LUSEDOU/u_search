import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:u_search_api/api.dart';

part 'applications_response.g.dart';

@JsonSerializable()

/// {@template applications_response}
/// Response from the applications endpoint.
/// {@endtemplate}
class ApplicationsResponse extends Equatable {
  /// {@macro applications_response}
  const ApplicationsResponse({
    required this.applications,
  });

  /// Converts a `Map<String, dynamic>` to a `ApplicationsResponse` instance.
  factory ApplicationsResponse.fromJson(Map<String, dynamic> json) =>
      _$ApplicationsResponseFromJson(json);

  final List<Apply> applications;

  /// Converts a `ApplicationsResponse` instance to a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() => _$ApplicationsResponseToJson(this);

  @override
  List<Object?> get props => [applications];
}
