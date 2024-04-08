//ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:u_search_flutter/welcome/welcome.dart';

void main() {
  group('WelcomeState', () {
    group('copyWith', () {
      test('returns same object when no properties are passed', () {
        final state = WelcomeState();
        expect(state.copyWith(), state);
      });

      test('returns object with updated status when status is passed', () {
        expect(
          WelcomeState().copyWith(status: FormzSubmissionStatus.success),
          equals(WelcomeState(status: FormzSubmissionStatus.success)),
        );
      });

      test('returns object with updated email when email is passed', () {
        expect(
          WelcomeState().copyWith(email: Email.dirty('email')),
          equals(WelcomeState(email: Email.dirty('email'))),
        );
      });
    });
  });
}
