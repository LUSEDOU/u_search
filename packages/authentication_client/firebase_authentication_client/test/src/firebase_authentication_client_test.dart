// ignore_for_file: prefer_const_constructors
import 'package:firebase_authentication_client/firebase_authentication_client.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

class FakeFirebaseAuthenticationClient extends Fake implements FirebaseAuthenticationClient {}

void main() {
  group('FirebaseAuthenticationClient', () {
    test('can be instantiated', () {
      expect(FakeFirebaseAuthenticationClient.new, returnsNormally);
    });
  });
}
