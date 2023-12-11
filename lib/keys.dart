import 'package:authentication_repository/authentication_repository.dart';
import 'package:data_repository/data_repository.dart';

class CacheKeys {
  /// {@macro cache_keys}
  CacheKeys()
      : _data = const _DataCacheKeys(),
        _auth = const _AuthCacheKeys();

  final DataCacheKeys _data;
  DataCacheKeys get data => _data;

  final AuthCacheKeys _auth;
  AuthCacheKeys get auth => _auth;
}

/// {@template cache_client}
/// Abstract class for CacheClient
/// {@endtemplate}
final class _DataCacheKeys extends DataCacheKeys {
  /// {@macro cache_keys}
  const _DataCacheKeys();

  @override
  String get roleCacheKey => 'role';
}

/// {@template cache_keys}
/// Abstract class for CacheKeys
/// {@endtemplate}
final class _AuthCacheKeys extends AuthCacheKeys {
  /// {@macro cache_keys}
  const _AuthCacheKeys();

  @override
  String get userCacheKey => 'user';
}
