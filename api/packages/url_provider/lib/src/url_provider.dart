/// {@template url_provider}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class UrlProvider {
  /// {@macro url_provider}
  const UrlProvider({
    String? baseUrl,
    String? webUrl,
  })  : _baseUrl = baseUrl,
        _webUrl = webUrl;

  final String? _baseUrl;
  final String? _webUrl;

  String get baseUrl => _baseUrl ?? 'https://localhost:8080';
  String get webUrl => _webUrl ?? 'http://localhost:58220';

  String link(String path) => '$baseUrl/$path';
  String webLink(String path) => '$webUrl/$path';
}
