part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

final class LoginRequested extends LoginEvent {
  const LoginRequested();
}

final class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

final class LoginSendEmailLink extends LoginEvent {
  const LoginSendEmailLink();
}
