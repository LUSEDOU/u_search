part of 'deep_link_exception.dart';

/// A generic Deep Link Client Interface.
abstract class DeepLinkClient {
  /// {@macro deep_link_client}
  const DeepLinkClient();

  /// Stream of [Uri] which will emit the deep link if there is one.
  Stream<Uri> get deepLinkStream;
}
