import 'package:authentication_client/authentication_client.dart';
import 'package:firebase_dart_flutter/firebase_dart_flutter.dart';

class FiredartAuthenticationClient extends AuthenticationClient {
  FiredartAuthenticationClient({
    FirebaseDartFlutter? firebaseDartFlutter,
  }) : _firebaseDartFlutter = firebaseDartFlutter ?? FirebaseDartFlutter() {
    FirebaseDartFlutter.setup();
  }

  final FirebaseDartFlutter _firebaseDartFlutter;

  @override
  bool isLogInWithEmailLink({
    required String emailLink,
  }) {
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
