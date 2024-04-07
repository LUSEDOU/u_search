part of 'welcome_cubit.dart';

/// {@template welcome_state}
/// Cubit state for the welcome page.
/// {@endtemplate}
class WelcomeState extends Equatable {
  /// {@macro welcome_state}
  const WelcomeState({
    this.email = const Email.pure(),
    this.status = FormzSubmissionStatus.initial,
  });

  final Email email;
  final FormzSubmissionStatus status;

  WelcomeState copyWith({
    Email? email,
    FormzSubmissionStatus? status,
  }) {
    return WelcomeState(
      email: email ?? this.email,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, status];
}
