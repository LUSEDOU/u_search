// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:url_provider/url_provider.dart';

void main() {
  group('UrlProvider', () {
    test('can be instantiated', () {
      expect(UrlProvider(), isNotNull);
    });
  });
}
