import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:u_search_api/api.dart';

part 'users_response.g.dart';

/// {@template users_response}
/// Response from the users endpoint.
/// {@endtemplate}
@JsonSerializable()
class UsersResponse extends Equatable {
  /// {@macro users_response}
  const UsersResponse({
    required this.users,
  });

  /// Converts a `Map<String, dynamic>` to a `UsersResponse` instance.
  factory UsersResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseFromJson(json);

  /// The list of users.
  final List<User> users;

  /// Converts a `UsersResponse` instance to a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() => _$UsersResponseToJson(this);

  @override
  List<Object?> get props => [users];

}
