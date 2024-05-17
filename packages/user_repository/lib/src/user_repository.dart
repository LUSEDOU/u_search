import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:storage/storage.dart';
import 'package:token_storage/token_storage.dart';
import 'package:u_search_api/client.dart';

part 'user_failure.dart';
part 'user_storage.dart';

/// {@template user_repository}
/// A repository that manages user data.
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  UserRepository({
    required TokenStorage tokenStorage,
    required USearchApiClient apiClient,
    // User user = User.anonymous,
  })  : _apiClient = apiClient,
        _tokenStorage = tokenStorage {
    unawaited(_init());
  }
  // _userController = BehaviorSubject<User>.seeded(user);

  final USearchApiClient _apiClient;
  final TokenStorage _tokenStorage;

  /// Stream of [User] which will emit the current user when the user changes.
  /// The initial value is [User.anonymous].

  Stream<User> get user => _userController.asBroadcastStream();
  final BehaviorSubject<User> _userController = BehaviorSubject<User>();

  Future<void> _init() async {
    try {
      final user = await _apiClient.me();
      if (user.isAnonymous) {
        await _tokenStorage.clearToken();
      }
      _userController.add(user);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  /// Sends a subscription request to the API.
  ///
  /// Throws a [SubscribeFailure] if an exception occurs.
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

  /// Sends a login email link to the provided [email].
  Future<void> sendLoginEmailLink({required String email}) async {
    try {
      await _apiClient.sendLoginEmailLink(email: email);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SendLoginEmailLinkFailure(error), stackTrace);
    }
  }

  /// Logs in with an email link.
  ///
  /// Throws a [LogInWithEmailLinkFailure] if an exception occurs.
  Future<void> logInWithEmailLink({
    required String token,
  }) async {
    try {
      final response = await _apiClient.loginWithEmailLink(token: token);
      await _tokenStorage.saveToken(response.token);
      _userController.add(response.user);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogInWithEmailLinkFailure(error), stackTrace);
    }
  }

  /// Logs out.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await _tokenStorage.clearToken();
      _userController.add(User.anonymous);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogOutFailure(error), stackTrace);
    }
  }
}
