// ignore_for_file: prefer_const_constructors

import 'package:deep_link_client/deep_link_client.dart';
import 'package:test/test.dart';

void main() {
  test('export DeepLinkFailure', () {
    expect(
      () => DeepLinkFailure('oops'),
      returnsNormally,
    );
  });
}
