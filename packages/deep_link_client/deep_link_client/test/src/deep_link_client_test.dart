// ignore_for_file: prefer_const_constructors
import 'package:deep_link_client/deep_link_client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class FakeDeepLinkClient extends Fake implements DeepLinkClient {}

void main() {
  group('DeepLinkClient', () {
    test('can be implemented', () {
      expect(FakeDeepLinkClient.new, returnsNormally);
    });
  });
}
