/// {@template cache_client}
/// Abstract class for CacheClient
/// {@endtemplate}
abstract class CacheClient {
  /// {@macro cache_client}
  const CacheClient();

  /// Read value from cache
  T? read<T>({required String key});

  /// Write value to cache
  void write<T>({required String key, required T value});

  /// Delete value from cache
  void delete({required String key});

  /// Delete all values from cache
  void deleteAll();
}

/// {@template cache_keys}
/// Abstract class for CacheKeys
/// {@endtemplate}
interface class CacheKeys {
  /// {@macro cache_keys}
  const CacheKeys();
}
