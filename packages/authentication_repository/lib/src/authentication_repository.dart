import 'package:authentication_repository/authentication_repository.dart';

/// {@template sing_up_failure}
/// Exception thrown when a sing up fails.
/// {@endtemplate}
class SingUpFailure implements Exception {
  /// {@macro sing_up_failure}
  const SingUpFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// [message] for the failure.
  final String message;
}

/// {@template log_in_failure}
/// Exception thrown when a log in fails.
/// {@endtemplate}
class LogInFailure implements Exception {
  /// {@macro log_in_failure}
  const LogInFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// [message] for the failure.
  final String message;
}

/// {@template log_out_failure}
/// Exception thrown when a log out fails.
/// {@endtemplate}
class LogOutFailure implements Exception {
  /// {@macro log_out_failure}
  const LogOutFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// [message] for the failure.
  final String message;
}

/// {@template authentication_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  const AuthenticationRepository({
    required CacheClient cacheClient,
    required AuthClient authClient,
    required String userCacheKey,
  })  : _cache = cacheClient,
        _auth = authClient,
        _userCacheKey = userCacheKey;

  final CacheClient _cache;
  final AuthClient _auth;

  /// User cache key.
  final String _userCacheKey;

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  User get currentUser => _cache.read<User>(key: _userCacheKey) ?? User.empty;

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user => _auth.authStateChanges().map((authUser) {
        final user = authUser ?? User.empty;
        _cache.write(key: _userCacheKey, value: user);
        return user;
      });

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SingUpFailure] if an exception occurs.
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signUp(email: email, password: password);
    } on Exception {
      throw const SingUpFailure();
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInFailure] if an exception occurs.
  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.logIn(email: email, password: password);
    } on Exception {
      throw const LogInFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  Future<void> logOut() async {
    try {
      await _auth.logOut();
    } on Exception {
      throw const LogOutFailure();
    }
  }
}
