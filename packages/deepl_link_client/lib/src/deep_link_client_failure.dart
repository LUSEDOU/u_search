import 'package:equatable/equatable.dart';

part 'deepl_link_client.dart';

/// {@template deepl_link_client_failure}
/// Indicates a failure during retrieval or processing of a deep link.
/// {@endtemplate}
class DeepLinkClientFailure with EquatableMixin implements Exception {
  /// {@macro deepl_link_client_failure}
  DeepLinkClientFailure(this.error);

  /// The error which was caught.
  final Object error;

  @override
  List<Object> get props => [error];
}
