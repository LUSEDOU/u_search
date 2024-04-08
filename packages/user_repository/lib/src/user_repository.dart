import 'package:equatable/equatable.dart';
import 'package:storage/storage.dart';
import 'package:u_search_api/client.dart';

part 'user_failure.dart';
part 'user_storage.dart';

/// {@template user_repository}
/// A repository that manages user data.
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  const UserRepository({
    required USearchApiClient apiClient,
  }) : _apiClient = apiClient;

  final USearchApiClient _apiClient;

  Future<void> subscribe({required String email}) async {
    try {
      final response = await _apiClient.subscribe(email: email);
      if (!response.success) {
        throw const SubscribeFailure('Failed to subscribe');
      }
    } on SubscribeFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SubscribeFailure(error), stackTrace);
    }
  }
  // const UserRepository({
  //   required UserStorage storage,
  //   required AuthenticationClient authenticationClient,
  //   required PackageInfoClient packageInfoClient,
  // })  : _authenticationClient = authenticationClient,
  //       _packageInfoClient = packageInfoClient,
  //       _storage = storage;
  //
  // final UserStorage _storage;
  // final AuthenticationClient _authenticationClient;
  // final PackageInfoClient _packageInfoClient;
  //
  // /// Sends an authentication link to the provided [email].
  // ///
  // /// Throws a [SendLoginEmailLinkFailure] if an exception occurs.
  // Future<void> sendLoginEmailLink(String email) async {
  //   try {
  //     await _authenticationClient.sendLoginEmailLink(
  //       email: email,
  //       appPackageName: _packageInfoClient.appName,
  //     );
  //   } catch (error, stackTrace) {
  //     Error.throwWithStackTrace(SendLoginEmailLinkFailure(error), stackTrace);
  //   }
  // }
  //
  // /// Logs in with an email link.
  // ///
  // /// Throws a [LogInWithEmailLinkFailure] if an exception occurs.
  // Future<void> logInWithEmailLink({
  //   required String email,
  //   required String emailLink,
  // }) async {
  //   try {
  //     await _authenticationClient.logInWithEmailLink(
  //       email: email,
  //       emailLink: emailLink,
  //     );
  //   } catch (error, stackTrace) {
  //     Error.throwWithStackTrace(LogInWithEmailLinkFailure(error), stackTrace);
  //   }
  // }
  //
  // /// Logs out the current user.
  // ///
  // /// Throws a [LogOutFailure] if an exception occurs.
  // Future<void> logOut() async {
  //   try {
  //     await _authenticationClient.logOut();
  //   } catch (error, stackTrace) {
  //     Error.throwWithStackTrace(LogOutFailure(error), stackTrace);
  //   }
  // }
}
