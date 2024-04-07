import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(const WelcomeState());

  void emailChanged(String value) {
    emit(state.copyWith(email: Email.dirty(value)));
  }

  Future<void> submit() async {
    final email = state.email;
    if (!email.isValid) return;

    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final isOnDomain = DomainEmail.dirty(state.email.value).isValid;

      if (isOnDomain) {
          /// Send email to the server
          /// Api call to send email
      }
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      addError(error, stackTrace);
    }
  }
}
