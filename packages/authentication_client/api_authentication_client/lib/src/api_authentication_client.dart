import 'package:authentication_client/authentication_client.dart';

class ApiAuthenticationClient extends AuthenticationClient {
  ApiAuthenticationClient();

  final ApiClient _apiClient;

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
