import 'package:authentication_repository/authentication_repository.dart';

/// {@template auth_client}
/// Abstract class for AuthClient
/// {@endtemplate}
abstract class AuthClient {
  /// {@macro auth_client}
  const AuthClient();

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  Stream<User?> authStateChanges();

  /// Sign up with [email] and [password].
  Future<void> singUp({required String email, required String password});

  /// Log in with [email] and [password].
  Future<void> logIn({required String email, required String password});

  /// Log out the current user which will emit [User.empty] from
  /// [authStateChanges].
  Future<void> logOut();
}
