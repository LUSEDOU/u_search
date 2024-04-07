import 'dart:convert';
import 'dart:io';

// import 'package:u_search_api/client.dart';
import 'package:http/http.dart' as http;
import 'package:u_search_api/api.dart';

/// {@template u_search_api_malformed_response}
/// An exception thrown when there is a problem decoded the response body.
/// {@endtemplate}
class USearchApiMalformedResponse implements Exception {
  /// {@macro u_search_api_malformed_response}
  const USearchApiMalformedResponse({required this.error});

  /// The associated error.
  final Object error;
}

/// {@template u_search_api_request_failure}
/// An exception thrown when an http request failure occurs.
/// {@endtemplate}
class USearchApiRequestFailure implements Exception {
  /// {@macro u_search_api_request_failure}
  const USearchApiRequestFailure({
    required this.statusCode,
    required this.body,
  });

  /// The associated http status code.
  final int statusCode;

  /// The associated response body.
  final Map<String, dynamic> body;
}

/// Signature for the authentication token provider.
typedef TokenProvider = Future<String?> Function();

/// {@template u_search_api_client}
/// A Dart API client for the Flutter News Example API.
/// {@endtemplate}
class USearchApiClient {
  /// Create an instance of [USearchApiClient] that integrates
  /// with the remote API.
  ///
  /// {@macro u_search_api_client}
  USearchApiClient({
    required TokenProvider tokenProvider,
    http.Client? httpClient,
  }) : this._(
          baseUrl: 'https://example-api.a.run.app',
          httpClient: httpClient,
          tokenProvider: tokenProvider,
        );

  /// Create an instance of [USearchApiClient] that integrates
  /// with a local instance of the API (http://localhost:8080).
  ///
  /// {@macro u_search_api_client}
  USearchApiClient.localhost({
    required TokenProvider tokenProvider,
    http.Client? httpClient,
  }) : this._(
          baseUrl: 'http://localhost:8080',
          httpClient: httpClient,
          tokenProvider: tokenProvider,
        );

  /// {@macro u_search_api_client}
  USearchApiClient._({
    required String baseUrl,
    required TokenProvider tokenProvider,
    http.Client? httpClient,
  })  : _baseUrl = baseUrl,
        _httpClient = httpClient ?? http.Client(),
        _tokenProvider = tokenProvider;

  final String _baseUrl;
  final http.Client _httpClient;
  final TokenProvider _tokenProvider;

  /// GET /api/v1/articles/<id>
  /// Requests article content metadata.
  ///
  /// Supported parameters:
  /// * [id] - Article id for which content is requested.
  /// * [limit] - The number of results to return.
  /// * [offset] - The (zero-based) offset of the first item
  /// in the collection to return.
  /// * [preview] - Whether to return a preview of the article.
  // Future<ArticleResponse> getArticle({
  //   required String id,
  //   int? limit,
  //   int? offset,
  //   bool preview = false,
  // }) async {
  //   final uri = Uri.parse('$_baseUrl/api/v1/articles/$id').replace(
  //     queryParameters: <String, String>{
  //       if (limit != null) 'limit': '$limit',
  //       if (offset != null) 'offset': '$offset',
  //       'preview': '$preview',
  //     },
  //   );
  //   final response = await _httpClient.get(
  //     uri,
  //     headers: await _getRequestHeaders(),
  //   );
  //   final body = response.json();

  //   if (response.statusCode != HttpStatus.ok) {
  //     throw USearchApiRequestFailure(
  //       body: body,
  //       statusCode: response.statusCode,
  //     );
  //   }
  //
  //   return ArticleResponse.fromJson(body);
  // }

  /// POST /api/v1/login
  /// Sends a email link to the user to login.
  ///
  /// Supported parameters:
  /// * [email] - The email to login with.
  Future<void> sendLoginEmail({
    required String email,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/v1/auth');

    final response = await _httpClient.post(
      uri,
      headers: await _getRequestHeaders(),
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw USearchApiRequestFailure(
        body: response.json(),
        statusCode: response.statusCode,
      );
    }
  }

  /// POST /api/v1/login
  /// Logs in the user with the provided email and token.
  ///
  /// Supported parameters:
  Future<LoginResponse> login({
    required String email,
    required String token,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/v1/login');

    final response = await _httpClient.post(
      uri,
      headers: await _getRequestHeaders(),
      body: jsonEncode(<String, String>{
        'email': email,
        'token': token,
      }),
    );
    final body = response.json();

    if (response.statusCode != HttpStatus.ok) {
      throw USearchApiRequestFailure(
        body: response.json(),
        statusCode: response.statusCode,
      );
    }

    return LoginResponse.fromJson(body);
  }

  /// POST /api/v1/subscribe
  /// Send a subscription request to the server.
  ///
  /// Supported parameters:
  /// * [email] - The email to subscribe with.
  Future<SubscribeResponse> subscribe({
    required String email,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/v1/subscribe');

    final response = await _httpClient.post(
      uri,
      headers: await _getRequestHeaders(),
      body: jsonEncode(
        <String, String>{
          'email': email,
        },
      ),
    );
    final body = response.json();

    if (response.statusCode != HttpStatus.ok) {
      throw USearchApiRequestFailure(
        body: body,
        statusCode: response.statusCode,
      );
    }

    return SubscribeResponse.fromJson(body);
  }

  Future<Map<String, String>> _getRequestHeaders() async {
    final token = await _tokenProvider();
    return <String, String>{
      HttpHeaders.contentTypeHeader: ContentType.json.value,
      HttpHeaders.acceptHeader: ContentType.json.value,
      if (token != null) HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }
}

extension on http.Response {
  Map<String, dynamic> json() {
    try {
      final decodedBody = utf8.decode(bodyBytes);
      return jsonDecode(decodedBody) as Map<String, dynamic>;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        USearchApiMalformedResponse(error: error),
        stackTrace,
      );
    }
  }
}
