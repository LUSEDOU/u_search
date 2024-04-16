import 'dart:convert';
import 'dart:io';

// import 'package:u_search_api/client.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:u_search_api/api.dart';

/// {@template u_search_api_malformed_response}
/// An exception thrown when there is a problem decoded the response body.
/// {@endtemplate}
class USearchApiMalformedResponse with EquatableMixin implements Exception {
  /// {@macro u_search_api_malformed_response}
  const USearchApiMalformedResponse({required this.error});

  /// The associated error.
  final Object error;

  @override
  List<Object?> get props => [error];
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

/// {@template u_search_api_unauthorized_request_failure}
/// An exception thrown when an unauthorized request is made.
/// {@endtemplate}
class USearchApiUnauthorizedRequestFailure implements Exception {
  /// {@macro u_search_api_unauthorized_request_failure}
  const USearchApiUnauthorizedRequestFailure();
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

  /// POST /api/v1/login
  ///
  /// Supported parameters:
  /// * [token] - The token to login with.
  ///
  /// Logs in the user with the provided token.
  ///
  /// Throws a [USearchApiRequestFailure] if an exception occurs.
  Future<LoginResponse> loginWithEmailLink({
    required String token,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/v1/login');

    final response = await _httpClient.post(
      uri,
      headers: await _getRequestHeaders(),
      body: jsonEncode(<String, String>{
        'token': token,
      }),
    );
    final body = response.json();

    if (response.statusCode != HttpStatus.ok) {
      throw USearchApiRequestFailure(
        body: body,
        statusCode: response.statusCode,
      );
    }

    return LoginResponse.fromJson(body);
  }

  /// POST /api/v1/auth
  /// Sends a login email link to the user.
  ///
  /// Supported parameters:
  /// * [email] - The email to send the login link to.
  ///
  /// Throws a [USearchApiRequestFailure] if an exception occurs.
  Future<void> sendLoginEmailLink({
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

  /// GET /api/v1/applies
  /// Requests all applies.
  ///
  /// Supported parameters:
  /// * [reviewer] - The reviewer id to filter by.
  /// * [researcher] - The researcher id to filter by.
  /// * [limit] - The number of results to return.
  /// * [offset] - The (zero-based) offset of the first item
  /// in the collection to return.
  ///
  /// Throws a [USearchApiRequestFailure] if an exception occurs.
  Future<List<Apply>> getApplies({
    int? reviewer,
    int? researcher,
    int? limit,
    int? offset,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/v1/applies').replace(
      queryParameters: <String, String>{
        if (reviewer != null) 'reviewer': '$reviewer',
        if (researcher != null) 'researcher': '$researcher',
        if (limit != null) 'limit': '$limit',
        if (offset != null) 'offset': '$offset',
      },
    );
    final response = await _httpClient.get(
      uri,
      headers: await _getRequestHeaders(),
    );
    final body = response.json();

    if (response.statusCode != HttpStatus.ok) {
      throw USearchApiRequestFailure(
        body: body,
        statusCode: response.statusCode,
      );
    }
  }

  /// POST /api/v1/applies
  /// Apply to a contest.
  ///
  /// Required parameters:
  /// * [researcher] - The researcher id to apply with.
  /// * [contest] - The contest id to apply to.
  /// * [research] - The research to apply with.
  ///
  /// Throws a [USearchApiRequestFailure] if an exception occurs.
  Future<void> apply({
    required int researcher,
    required int contest,
    required Research research,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/v1/applies');

    final response = await _httpClient.post(
      uri,
      headers: await _getRequestHeaders(),
      body: jsonEncode(
        <String, int>{
          'researcher': researcher,
          'contest': contest,
        },
      ),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw USearchApiRequestFailure(
        body: response.json(),
        statusCode: response.statusCode,
      );
    }
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
