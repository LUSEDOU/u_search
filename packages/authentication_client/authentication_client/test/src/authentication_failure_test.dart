// ignore_for_file: prefer_const_constructors
import 'package:authentication_client/authentication_client.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

class FakeAuthenticationFailure extends Fake implements AuthenticationFailure {}

void main() {
  group('AuthenticationFailure', () {
    test('can be instantiated', () {
      expect(FakeAuthenticationFailure.new, returnsNormally);
    });
  });
}
