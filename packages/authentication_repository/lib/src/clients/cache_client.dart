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
}
