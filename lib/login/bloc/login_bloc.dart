import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:user_repository/user_repository.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginSendEmailLink>(_onSendEmailLink);
  }

  final UserRepository _userRepository;

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email]),
      ),
    );
  }

  Future<void> _onSendEmailLink(
    LoginSendEmailLink event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _userRepository.sendLoginiEmailLink(state.email.value);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      addError(error, stackTrace);
    }
  }
}
