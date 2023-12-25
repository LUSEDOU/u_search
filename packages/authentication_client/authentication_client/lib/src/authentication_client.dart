import 'package:authentication_client/authentication_client.dart';

part 'authentication_exception.dart';

/// A generic authentication client.
abstract class AuthenticationClient {
  /// Stream of [AuthenticationUser] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [AuthenticationUser.anonymous] if the user is not authenticated.
  Stream<AuthenticationUser> get user;

  /// Sends an authentication link to the provided [email]
  ///
  /// Opening the link should redirect to the app with [appPackageName]
  /// and authenticate the user based on the provided email.
  ///
  /// Throws a [SendLoginEmailLinkFailure] if an exception occurs.
  Future<void> sendLoginEmailLink({
    required String email,
    required String appPackageName,
  });

  /// Checks if an incoming [emailLink] is a sign-in with the email link
  ///
  /// Throws a [IsLogInWithEmailLinkFailure] if an exception occurs.
  bool isLogInWithEmailLink({
    required String emailLink,
  });

  /// Signs in with the provided [email] and [emailLink].
  ///
  /// Throws a [LogInWithEmailLinkFailure] if an exception occurs.
  Future<void> logInWithEmailLink({
    required String email,
    required String emailLink,
  });

  /// Signs out the current user which will emit
  /// [AuthenticationUser.anonymous] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut();
}
