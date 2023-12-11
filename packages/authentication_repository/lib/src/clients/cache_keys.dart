import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache_client/cache_client.dart';

/// {@template auth_cache_keys}
/// An extension of [CacheKeys] that contains keys for the authentication layer.
/// {@endtemplate}
abstract class AuthCacheKeys implements CacheKeys {
  /// {@macro auth_cache_keys}
  const AuthCacheKeys();

  /// The key for accessing the current [User].
  String get userCacheKey;
}
