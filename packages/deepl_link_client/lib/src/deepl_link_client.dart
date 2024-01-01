import 'dart:async';

import 'package:equatable/equatable.dart';

part of 'deep_link_client_failure.dart';

/// {@template deepl_link_client}
/// A client that exposes a stream of deep link URIs redirected to the app.
/// {@endtemplate}
abstract class DeeplLinkClient {
  /// {@macro deepl_link_client}
  DeeplLinkClient() : _deepLinkSubject = BehaviorSubject<Uri>() {
    unawaited(_getInitialLink());
  }

  final BehaviorSubject<Uri> _deepLinkSubject;

  /// Provides a stream of deep link URIs redirected to the app.
  ///
  /// Will emit the latest received value (if any) as first.
  Stream<Uri> get deepLinkStream => _deepLinkSubject;

  Future<void> _getInitialLink();


}
