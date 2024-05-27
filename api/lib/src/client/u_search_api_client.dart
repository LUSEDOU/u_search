import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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

  @override
  String toString() {
    return 'USearchApiRequestFailure: $statusCode $body';
  }
}

/// {@template u_search_api_unauthorized_request_failure}
/// An exception thrown when an unauthorized request is made.
/// {@endtemplate}
class USearchApiUnauthorizedFailure implements Exception {
  /// {@macro u_search_api_unauthorized_request_failure}
  const USearchApiUnauthorizedFailure();
}

/// Signature for the authentication token provider.
typedef TokenProvider = Future<String> Function();

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

  /// GET /api/v1/me
  Future<User> me() async {
    final uri = Uri.parse('$_baseUrl/api/v1/me');

    final response = await _httpClient.get(
      uri,
      headers: await _getRequestHeaders(),
    );

    if (response.statusCode != HttpStatus.ok) {
      return User.anonymous;
    }
    final body = response.json();

    return User.fromJson(body);
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
      body: jsonEncode(
        <String, String>{
          'token': token,
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
    try {
      final uri = Uri.parse('$_baseUrl/api/v1/auth');

      final response = await _httpClient.post(
        uri,
        headers: await _getRequestHeaders(),
        body: jsonEncode(
          <String, String>{
            'email': email,
          },
        ),
      );

      if (response.statusCode != HttpStatus.ok) {
        throw USearchApiRequestFailure(
          body: response.json(),
          statusCode: response.statusCode,
        );
      }
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        USearchApiMalformedResponse(error: error),
        stackTrace,
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
  Future<ApplicationsResponse> getApplies({
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

    return ApplicationsResponse.fromJson(body);
  }

  /// POST /api/v1/applies
  /// Apply to a contest.
  ///
  /// Required parameters:
  /// * [contest] - The contest id to apply to.
  /// * [research] - The research to apply with.
  ///
  /// Throws a [USearchApiRequestFailure] if an exception occurs.
  Future<Apply> apply({
    required int contest,
    required int research,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/v1/applies');

    final response = await _httpClient.post(
      uri,
      headers: await _getRequestHeaders(),
      body: jsonEncode(
        <String, int>{
          'contest': contest,
          'research': research,
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
    return Apply.fromJson(body);
  }

  /// GET /api/v1/applies/<id>
  ///
  /// Required parameters:
  /// * [id] - The apply id to fetch.
  ///
  /// Throws a [USearchApiRequestFailure] if an exception occurs.
  /// Throws a [USearchApiUnauthorizedFailure] if the request is unauthorized.
  Future<Apply> getApply({
    required int id,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/v1/applies/$id');
    final response = await _httpClient.get(
      uri,
      headers: await _getRequestHeaders(),
    );
    final body = response.json();

    switch (response.statusCode) {
      case HttpStatus.unauthorized:
        throw const USearchApiUnauthorizedFailure();
      case HttpStatus.ok:
        return Apply.fromJson(body);
      case _:
        throw USearchApiRequestFailure(
          body: body,
          statusCode: response.statusCode,
        );
    }
  }

  /// POST /api/v1/applies/<apply>/reviewer
  /// Select a reviewer for an apply.
  ///
  /// Required parameters:
  /// * [apply] - The apply id to select a reviewer for.
  /// * [reviewer] - The reviewer id to select.
  ///
  /// Throws a [USearchApiRequestFailure] if an exception occurs.
  Future<void> selectReviewer({
    required int apply,
    required int reviewer,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/v1/applies/$apply/reviewer');

    final response = await _httpClient.post(
      uri,
      headers: await _getRequestHeaders(),
      body: jsonEncode(<String, int>{
        'reviewer': reviewer,
      }),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw USearchApiRequestFailure(
        body: response.json(),
        statusCode: response.statusCode,
      );
    }
  }

  /// GET /api/v1/applies/<apply>/review
  /// Get the review of an apply.
  ///
  /// Required parameters:
  /// * [apply] - The apply id to select a reviewer for.
  ///
  /// Throws a [USearchApiRequestFailure] if an exception occurs.
  Future<Review> getReview({
    required int apply,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/v1/applies/$apply/review');

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

    return Review.fromJson(body);
  }

  /// POST /api/v1/applies/<apply>/review
  /// Submit a review for an apply.
  ///
  /// Required parameters:
  /// * [apply] - The apply id to select a reviewer for.
  ///
  /// Throws a [USearchApiRequestFailure] if an exception occurs.
  Future<Review> submitReview({
    required int apply,
    required Review review,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/v1/applies/$apply/review');

    final response = await _httpClient.post(
      uri,
      headers: await _getRequestHeaders(),
      body: jsonEncode(review.toJson()),
    );

    final body = response.json();

    if (response.statusCode != HttpStatus.ok) {
      throw USearchApiRequestFailure(
        body: response.json(),
        statusCode: response.statusCode,
      );
    }

    return Review.fromJson(body);
  }

  /// POST /api/v1/researches
  /// Submit the research PDF file to the server.
  ///
  /// Required parameters:
  /// * [bytes] - The bytes of the research PDF file.
  /// * [title] - The title of the research.
  ///
  /// Throws a [USearchApiRequestFailure] if an exception occurs.
  Future<Research> submitResearch({
    required Uint8List bytes,
    required String title,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/v1/researches');

    final encodedFile = base64Encode(bytes);

    final response = await _httpClient.post(
      uri,
      headers: await _getRequestHeaders(),
      body: jsonEncode(
        <String, String>{
          'file': encodedFile,
          'title': title,
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
    return Research.fromJson(body);
  }

  /// GET /api/v1/contests
  /// Requests all contests.
  ///
  /// Supported parameters:
  ///
  /// Throws a [USearchApiRequestFailure] if an exception occurs.
  Future<ContestResponse> getContests() async {
    final uri = Uri.parse('$_baseUrl/api/v1/contests');
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

    return ContestResponse.fromJson(body);
  }

  /// GET /api/v1/contests/<id>
  /// Requests a contest.
  ///
  /// Required parameters:
  /// * [id] - The contest id to fetch.
  ///
  /// Throws a [USearchApiRequestFailure] if an exception occurs.
  Future<Contest> getContest({
    required int id,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/v1/contests/$id');
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

    return Contest.fromJson(body);
  }

  /// GET /api/v1/users/reviewers
  /// Requests all reviewers.
  ///
  /// Throws a [USearchApiRequestFailure] if an exception occurs.
  Future<ReviewerResponse> getReviewers() async {
    final uri = Uri.parse('$_baseUrl/api/v1/users/reviewers');
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

    return ReviewerResponse.fromJson(body);
  }

  Future<String> downloadResearch({
    required int research,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/v1/researches/$research');

    final r = await _httpClient.get(
      uri,
      headers: await _getRequestHeaders(),
    );

    if (r.statusCode != HttpStatus.ok) {
      throw USearchApiRequestFailure(
        body: r.json(),
        statusCode: r.statusCode,
      );
    }

    return r.json()['base64'] as String;
  }

  Future<Map<String, String>> _getRequestHeaders() async {
    final token = await _tokenProvider();
    return <String, String>{
      HttpHeaders.contentTypeHeader: ContentType.json.value,
      HttpHeaders.acceptHeader: ContentType.json.value,
      HttpHeaders.authorizationHeader: 'Bearer $token',
      'Authorization': 'Bearer $token',
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
