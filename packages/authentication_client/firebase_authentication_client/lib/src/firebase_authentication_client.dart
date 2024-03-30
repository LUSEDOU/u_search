import 'package:authentication_client/authentication_client.dart';
import 'package:equatable/equatable.dart';

part 'firebase_authentication_failure.dart';

/// {@template firebase_authentication_client}
/// A client that manages Firebase authentication.
/// {@endtemplate}
class FirebaseAuthenticationClient extends AuthenticationClient {
  /// {@macro firebase_authentication_client}
  FirebaseAuthenticationClient();

  @override
  bool isLogInWithEmailLink({required String emailLink}) {
    // TODO: implement isLogInWithEmailLink
    throw UnimplementedError();
  }

  @override
  Future<void> logInWithEmailLink({
    required String email,
    required String emailLink,
  }) {
    // TODO: implement logInWithEmailLink
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<void> sendLoginEmailLink({
    required String email,
    required String appPackageName,
  }) {
    // TODO: implement sendLoginEmailLink
    throw UnimplementedError();
  }
}
