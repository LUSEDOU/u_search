import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:u_search_api/api.dart';

part 'login_response.g.dart';

/// {@template login_response}
/// Response from the login endpoint.
/// {@endtemplate}
@JsonSerializable()
class LoginResponse extends Equatable {
  /// {@macro login_response}
  const LoginResponse({
    required this.token,
    required this.user,
  });

  /// Converts a `Map<String, dynamic>` to a `LoginResponse` instance.
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  /// The user's authentication token.
  final String token;

  /// The user's information.
  final User user;

  /// Converts a `LoginResponse` instance to a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @override
  List<Object?> get props => [token, user];
}
