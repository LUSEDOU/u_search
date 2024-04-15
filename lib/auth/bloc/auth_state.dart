part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  success,
  failure,
}

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.email = const Email.pure(),
    this.isValid = false,
    this.error,
  });

  final AuthStatus status;
  final bool isValid;
  final Email email;
  final String? error;

  AuthState copyWith({
    AuthStatus? status,
    Email? email,
    bool? isValid,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      email: email ?? this.email,
      isValid: isValid ?? this.isValid,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, email, isValid,error];
}
