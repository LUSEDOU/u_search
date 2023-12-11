import 'package:cache_client/cache_client.dart';
import 'package:data_repository/data_repository.dart';

/// {@template data_cache_keys}
/// An extension of [CacheKeys] that contains keys for the data layer.
/// {@endtemplate}
abstract class DataCacheKeys implements CacheKeys {
  /// {@macro data_cache_keys}
  const DataCacheKeys();

  /// The key for accessing the current [Role].
  String get roleCacheKey;
}
