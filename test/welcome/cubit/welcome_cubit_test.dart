//ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:mocktail/mocktail.dart';
import 'package:u_search_flutter/welcome/cubit/welcome_cubit.dart';
import 'package:user_repository/user_repository.dart';

class _MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('WelcomeCubit', () {
    late UserRepository userRepository;
    const validEmail = Email.dirty('test@test.com');

    setUp(() {
      userRepository = _MockUserRepository();
    });

    group('emailChanged', () {
      blocTest<WelcomeCubit, WelcomeState>(
        'emits email',
        build: () => WelcomeCubit(userRepository: userRepository),
        act: (cubit) => cubit.emailChanged(validEmail.value),
        expect: () => const <WelcomeState>[
          WelcomeState(email: validEmail),
        ],
      );
    });

    group('submit', () {
      blocTest<WelcomeCubit, WelcomeState>(
        'no emit when email is invalid',
        seed: () => WelcomeState(email: Email.dirty()),
        build: () => WelcomeCubit(userRepository: userRepository),
        act: (cubit) => cubit.submit(),
        expect: () => const <WelcomeState>[],
      );

      blocTest<WelcomeCubit, WelcomeState>(
        'emits in progress and success when subscribe succeeds',
        setUp: () => when(
          () => userRepository.subscribe(email: any(named: 'email')),
        ).thenAnswer(Future.value),
        seed: () => WelcomeState(email: validEmail),
        build: () => WelcomeCubit(userRepository: userRepository),
        act: (cubit) => cubit.submit(),
        expect: () => const <WelcomeState>[
          WelcomeState(
            email: validEmail,
            status: FormzSubmissionStatus.inProgress,
          ),
          WelcomeState(
            email: validEmail,
            status: FormzSubmissionStatus.success,
          ),
        ],
      );

      blocTest<WelcomeCubit, WelcomeState>(
        'emits in progress and failure when subscribe fails',
        setUp: () => when(
          () => userRepository.subscribe(email: any(named: 'email')),
        ).thenThrow(Exception()),
        seed: () => WelcomeState(email: validEmail),
        build: () => WelcomeCubit(userRepository: userRepository),
        act: (cubit) => cubit.submit(),
        expect: () => const <WelcomeState>[
          WelcomeState(
            email: validEmail,
            status: FormzSubmissionStatus.inProgress,
          ),
          WelcomeState(
            email: validEmail,
            status: FormzSubmissionStatus.failure,
          ),
        ],
      );
    });
  });
}
