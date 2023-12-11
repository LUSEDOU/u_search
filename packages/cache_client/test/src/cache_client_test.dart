// ignore_for_file: prefer_const_constructors
import 'package:cache_client/cache_client.dart';
import 'package:test/test.dart';

void main() {
  group('CacheClient', () {
    test('can be instantiated', () {
      expect(CacheClient(), isNotNull);
    });
  });
}
