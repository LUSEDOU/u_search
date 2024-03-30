// ignore_for_file: prefer_const_constructors
import 'package:authentication_client/authentication_client.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

class FakeAuthenticationClient extends Fake implements AuthenticationClient {}

void main() {
  group('AuthenticationClient', () {
    test('can be instantiated', () {
      expect(FakeAuthenticationClient.new, returnsNormally);
    });
  });
}
