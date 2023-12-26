part of 'user_repository.dart';

/// Storage keys for the [UserStorage].
abstract class UserStorageKeys {
  /// Number of times that a user opened the application.
  static const appOpenedCount = '__app_opened_count_key__';
}

/// {@template user_storage}
/// Storage for the [UserRepository].
/// {@endtemplate}
class UserStorage {
  /// {@macro user_storage}
  const UserStorage();

  /// Sets the number of times that a user opened the application.
  Future<void> setAppOpenedCount({required int count}) async => null;

  /// Fetches the number of times that a user opened the application.
  Future<int> fetchAppOpenedCount() async => 0;
}
