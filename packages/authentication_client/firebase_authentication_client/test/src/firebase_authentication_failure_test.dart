// ignore_for_file: prefer_const_constructors
import 'package:firebase_authentication_client/firebase_authentication_client.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

class FakeFirebaseAuthenticationFailure extends Fake implements FirebaseAuthenticationFailure {}

void main() {
  group('FirebaseAuthenticationFailure', () {
    test('can be instantiated', () {
      expect(FakeFirebaseAuthenticationFailure.new, returnsNormally);
    });
  });
}
