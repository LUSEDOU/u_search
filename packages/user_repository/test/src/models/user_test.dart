// ignore_for_file: prefer_const_constructors

import 'package:authentication_client/authentication_client.dart';
import 'package:test/test.dart';
import 'package:u_search_api/client.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  group('User', () {
    group('fromAuthenticationUser', () {
      test('initializes correctly', () {
        final authenticationUser = AuthenticationUser(id: 'id');
        const role = RoleType.reviewer;

        expect(
          User.fromAuthenticationUser(
            authenticationUser: authenticationUser,
            role: role,
          ),
          equals(
            User(
              role: role,
              id: 'id',
            ),
          ),
        );
      });
    });

    group('isAnonymous', () {
      test('sets isAnonymous correctly', () {
        const anonymousUser = User.anonymous;
        expect(anonymousUser.isAnonymous, isTrue);
      });
    });
  });
}
