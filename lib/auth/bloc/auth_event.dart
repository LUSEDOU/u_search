part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthRequested extends AuthEvent {
  const AuthRequested(this.token);

  final String? token;

  @override
  List<Object?> get props => [token];
}

final class AuthEmailChanged extends AuthEvent {
  const AuthEmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

final class AuthEmailSubmitted extends AuthEvent {
  const AuthEmailSubmitted(this.email);
                // onChanged: (email) =>
                //     context.read<AuthBloc>().add(AuthEmailChanged(email)),

  final String email;

  @override
  List<Object?> get props => [email];

  @override
  String toString() => 'AuthEmailSubmitted { email: $email }';
}
