part of 'u_search_api_client.dart';

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
