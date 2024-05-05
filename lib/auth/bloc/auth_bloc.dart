import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:user_repository/user_repository.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const AuthState()) {
    on<AuthRequested>(_onRequested);
    on<AuthEmailChanged>(_onEmailChanged);
    on<AuthEmailSubmitted>(_onSubmitted);
  }

  final UserRepository _userRepository;

  Future<void> _onRequested(
    AuthRequested event,
    Emitter<AuthState> emit,
  ) async {
    final token = event.token;
    if (token == null) return;

    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _userRepository.logInWithEmailLink(token: token);
      emit(state.copyWith(status: AuthStatus.success));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: AuthStatus.failure));
      addError(error, stackTrace);
    }
  }

  void _onEmailChanged(
    AuthEmailChanged event,
    Emitter<AuthState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: email.isValid,
      ),
    );
  }

  Future<void> _onSubmitted(
    AuthEmailSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    if (!state.isValid) return;

    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _userRepository.sendLoginEmailLink(email: state.email.value);
      emit(state.copyWith(status: AuthStatus.success));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: AuthStatus.failure));
    }
  }
}
