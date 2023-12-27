part 'storage_exception.dart';

/// A Dart Storage Client Interface
abstract class Storage {
  /// Returns value for the provided [key]
  /// Read returns `null` if no value is found for the given [key].
  /// Throws [StorageException] if an error occurs while reading.
  Future<String?> read({required String key});

  /// Writes the provided [key], [value] pair asynchronously.
  /// Throws [StorageException] if the write fails.
  Future<void> write({required String key, required String value});

  /// Removes the value for the provided [key] asynchronously.
  /// Throws [StorageException] if the delete fails.
  Future<void> delete({required String key});

  /// Removes all key value pairs asynchronously.
  /// Throws [StorageException] if the clear fails.
  Future<void> clear();
}
