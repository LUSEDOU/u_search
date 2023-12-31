import 'package:authentication_client/authentication_client.dart';
import 'package:u_search_api/client.dart';

/// {@template user}
/// User model represents the current user with its role.
/// {@endtemplate}
class User extends AuthenticationUser {
  /// {@macro user}
  const User({
    required this.role,
    required super.id,
    super.email,
    super.name,
    super.isNewUser,
  });

  /// Converts [AuthenticationUser] to [User] with [RoleType].
  factory User.fromAuthenticationUser({
    required AuthenticationUser authenticationUser,
    required RoleType role,
  }) =>
      User(
        id: authenticationUser.id,
        email: authenticationUser.email,
        name: authenticationUser.name,
        isNewUser: authenticationUser.isNewUser,
        role: role,
      );

  /// Whether the current user is anonymous.
  @override
  bool get isAnonymous => id.isEmpty;

  /// Whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Whether the current user has a role.
  bool get hasRole => role != RoleType.none;

  /// Anonymous user which represents an unauthenticated user.
  static const User empty = User(
    id: '',
    role: RoleType.none,
  );

  /// The role of the user.
  final RoleType role;
}
