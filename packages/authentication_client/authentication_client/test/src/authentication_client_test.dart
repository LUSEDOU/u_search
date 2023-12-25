// ignore_for_file: prefer_const_constructors
import 'package:authentication_client/authentication_client.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

class FakeAuthenticationClient extends Fake implements AuthenticationClient {}

void main() {
  group('AuthenticationClient', () {
    test('AuthenticationClient can be implemented', () {
      expect(
        FakeAuthenticationClient.new,
        returnsNormally,
      );
    });

    test('exports SendLoginEmailLinkFeailure', () {
      expect(
        () => SendLoginEmailLinkFailure('oops'),
        returnsNormally,
      );
    });

    test('exports IsLogInWithEmailLinkFailure', () {
      expect(
        () => IsLogInWithEmailLinkFailure('oops'),
        returnsNormally,
      );
    });

    test('exports LogInWithEmailLinkFailure', () {
      expect(
        () => LogInWithEmailLinkFailure('oops'),
        returnsNormally,
      );
    });

    test('exports LogOutFailure', () {
      expect(
        () => LogOutFailure('oops'),
        returnsNormally,
      );
    });
  });
}
