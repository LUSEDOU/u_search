part of 'login_with_email_link_bloc.dart';

sealed class LoginWithEmailLinkEvent extends Equatable {
  const LoginWithEmailLinkEvent();

  @override
  List<Object> get props => [];
}

class LoginWithEmailLinkSubmitted extends LoginWithEmailLinkEvent {
  const LoginWithEmailLinkSubmitted(this.emailLink);

  final Uri emailLink;

  @override
  List<Object> get props => [emailLink];
}
