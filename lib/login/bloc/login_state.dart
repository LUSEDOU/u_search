part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.isValid = false,
    this.error,
  });

  final FormzSubmissionStatus status;
  final Email email;
  final bool isValid;
  final String? error;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    bool? isValid,
    String? error,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      isValid: isValid ?? this.isValid,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, email, isValid, error];
}
