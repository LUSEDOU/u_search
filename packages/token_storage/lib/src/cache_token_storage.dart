import 'package:shared_preferences/shared_preferences.dart';
import 'package:token_storage/src/token_storage.dart';

/// {@template cache_token_storage}
/// Cache token storage for the authentication client.
/// {@endtemplate}
class CacheTokenStorage implements TokenStorage {
  /// {@macro cache_token_storage}
  const CacheTokenStorage({
    required SharedPreferences preferences,
    required String anonymousToken,
  })  : _preferences = preferences,
        _anonymousToken = anonymousToken;

  final SharedPreferences _preferences;
  final String _anonymousToken;

  static const _tokenKey = '___token___';

  @override
  Future<void> clearToken() async {
    await saveToken(_anonymousToken);
  }

  @override
  Future<String?> readToken() async {
    final token = _preferences.getString(_tokenKey);
    return token ?? _anonymousToken;
  }

  @override
  Future<void> saveToken(String token) async {
    await _preferences.setString(_tokenKey, token);
    return;
  }
}
