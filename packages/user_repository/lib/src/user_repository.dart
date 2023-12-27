import 'package:authentication_client/authentication_client.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:u_search_api/client.dart';
import 'package:user_repository/user_repository.dart';

part 'user_storage.dart';
part 'user_failure.dart';

/// {@template user_repository}
/// Repository which manages the user domain.
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  UserRepository({
    required AuthenticationClient authenticationClient,
    required UserStorage storage,
  })  : _authenticationClient = authenticationClient,
        _storage = storage;

  final AuthenticationClient _authenticationClient;
  final UserStorage _storage;

  /// Stream of [User] which will emit the current user when
  /// the authentication state or the role changes.
  Stream<User> get user =>
      Rx.combineLatest2<AuthenticationUser, RoleType, User>(
        _authenticationClient.user,
        _currentRoleTypeSubject.stream,
        (authenticationUser, roleType) => User.fromAuthenticationUser(
          authenticationUser: authenticationUser,
          role: authenticationUser.isAnonymous ? RoleType.none : roleType,
        ),
      ).asBroadcastStream();

  final BehaviorSubject<RoleType> _currentRoleTypeSubject =
      BehaviorSubject.seeded(RoleType.none);

  /// Sends an authentication link to the provided [email].
  ///
  /// Throws a [SendLoginEmailLinkFailure] if an exception occurs.
  Future<void> sendLoginEmailLink({
    required String email,
  }) async {
    try {
      await _authenticationClient.sendLoginEmailLink(
        email: email,
        appPackageName: '',
      );
    } on SendLoginEmailLinkFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SendLoginEmailLinkFailure(error), stackTrace);
    }
  }

  /// Signs in with the provided [email] and [emailLink].
  ///
  /// Throws a [LogInWithEmailLinkFailure] if an exception occurs.
  Future<void> logInWithEmailLink({
    required String email,
    required String emailLink,
  }) async {
    try {
      await _authenticationClient.logInWithEmailLink(
        email: email,
        emailLink: emailLink,
      );
    } on LogInWithEmailLinkFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogInWithEmailLinkFailure(error), stackTrace);
    }
  }

  /// Signs out the current user which will emit
  /// [User.anonymous] from the [user] stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await _authenticationClient.logOut();
    } on LogOutFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogOutFailure(error), stackTrace);
    }
  }

  /// Increments the number of times the app was opened by 1.
  Future<void> incrementAppOpenedCount() async {
    try {
      final value = await fetchAppOpenedCount();
      await _storage.setAppOpenedCount(count: value + 1);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        IncrementAppOpenedCountFailure(error),
        stackTrace,
      );
    }
  }

  /// Returns the number of times the app was opened.
  Future<int> fetchAppOpenedCount() async {
    try {
      return await _storage.fetchAppOpenedCount();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        FetchAppOpenedCountFailure(error),
        stackTrace,
      );
    }
  }
}
