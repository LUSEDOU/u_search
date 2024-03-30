import 'package:authentication_client/authentication_client.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'firebase_authentication_failure.dart';

/// {@template firebase_authentication_client}
/// A client that manages Firebase authentication.
/// {@endtemplate}
class FirebaseAuthenticationClient extends AuthenticationClient {
  /// {@macro firebase_authentication_client}
  FirebaseAuthenticationClient({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  @override
  bool isLogInWithEmailLink({
    required String emailLink,
  }) {
    try {
      return _firebaseAuth.isSignInWithEmailLink(emailLink);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(IsLogInWithEmailLinkFailure(error), stackTrace);
    }
  }

  @override
  Future<void> logInWithEmailLink({
    required String email,
    required String emailLink,
  }) {
    try {
      return _firebaseAuth.signInWithEmailLink(
        email: email,
        emailLink: emailLink,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogInWithEmailLinkFailure(error), stackTrace);
    }
  }

  @override
  Future<void> logOut() {
    try {
      return _firebaseAuth.signOut();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogOutFailure(error), stackTrace);
    }
  }

  @override
  Future<void> sendLoginEmailLink({
    required String email,
    required String appPackageName,
  }) {
    try {
      const url = 'http://localhost:44525/email_login';

      final actionCodeSettings = ActionCodeSettings(
        url: url,
        handleCodeInApp: true,
        androidPackageName: appPackageName,
        androidInstallApp: true,
        androidMinimumVersion: '12',
        iOSBundleId: appPackageName,
      );
      return _firebaseAuth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: actionCodeSettings,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SendLoginEmailLinkFailure(error), stackTrace);
    }
  }
}
