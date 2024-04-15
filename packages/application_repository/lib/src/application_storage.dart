part of 'application_repository.dart';

/// Storage keys for the [ApplicationStorage].
abstract class ApplicationStorageKeys {}

/// {@template application_storage}
/// Storage for the [ApplicationRepository].
/// {@endtemplate}
class ApplicationStorage {
  /// {@macro application_storage}
  const ApplicationStorage({
    required Storage storage,
  }) : _storage = storage;

  final Storage _storage;
}
