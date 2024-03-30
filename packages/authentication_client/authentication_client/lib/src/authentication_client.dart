import 'package:equatable/equatable.dart';

part 'authentication_failure.dart';

/// A generic Authentication Interface.
abstract class AuthenticationClient {

  /// Sends an authentication link to the provided [email].
  ///
  /// Opening the link should redirect to the app with [appPackageName]
  /// and authenticate the user based on the provided email link.
  ///
  /// Throws a [SendLoginEmailLinkFailure] if an exception occurs.
  Future<void> sendLoginEmailLink({
    required String email,
    required String appPackageName,
  });

  /// Checks if an incoming [emailLink] is a sign-in with email link.
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
