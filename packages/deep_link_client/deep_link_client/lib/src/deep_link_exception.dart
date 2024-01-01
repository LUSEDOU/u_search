part of 'deep_link_client.dart';

/// {@template deep_link_exception}
/// Exception from the deep link client.
/// {@endtemplate}
class DeepLinkFailure implements Exception {
  /// {@macro deep_link_exception}
  const DeepLinkFailure(this.error);

  /// The error which was caught.
  final Object error;
}
