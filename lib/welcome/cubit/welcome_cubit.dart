import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:user_repository/user_repository.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const WelcomeState());

  final UserRepository _userRepository;

  void emailChanged(String value) {
    emit(state.copyWith(email: Email.dirty(value)));
  }

  Future<void> submit() async {
    final email = state.email;
    if (!email.isValid) return;

    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await _userRepository.subscribe(email: email.value);

      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      addError(error, stackTrace);
    }
  }
}
