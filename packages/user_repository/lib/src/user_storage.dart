part of 'user_repository.dart';

/// Storage keys for the [UserStorage].
abstract class UserStorageKeys {}

/// {@template user_storage}
/// Storage for the [UserRepository].
/// {@endtemplate}
class UserStorage {
  /// {@macro user_storage}
  const UserStorage({
    required Storage storage,
  }) : _storage = storage;

  final Storage _storage;
}
