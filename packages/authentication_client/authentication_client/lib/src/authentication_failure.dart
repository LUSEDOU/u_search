part of 'authentication_client.dart';

/// {@template authentication_failure}
/// Exception from the authentication client.
/// {@endtemplate}
abstract class AuthenticationFailure with EquatableMixin implements Exception {
  /// {@macro authentication_failure}
  const AuthenticationFailure(this.error);

  /// The error which was caught.
  final Object error;

  @override
  List<Object> get props => [error];
}

/// {@template send_login_email_link_failure}
/// Exception thrown when sending a login email link fails.
/// {@endtemplate}
class SendLoginEmailLinkFailure extends AuthenticationFailure {
  /// {@macro send_login_email_link_failure}
  const SendLoginEmailLinkFailure(super.error);
}

/// {@template is_log_in_email_link_failure}
/// Thrown during the validation of the email link process if a failure occurs.
/// {@endtemplate}
class IsLogInWithEmailLinkFailure extends AuthenticationFailure {
  /// {@macro is_log_in_email_link_failure}
  const IsLogInWithEmailLinkFailure(super.error);
}

/// {@template log_in_with_email_link_failure}
/// Thrown during the sign in with email link process if a failure occurs.
/// {@endtemplate}
class LogInWithEmailLinkFailure extends AuthenticationFailure {
  /// {@macro log_in_with_email_link_failure}
  const LogInWithEmailLinkFailure(super.error);
}

/// {@template log_out_failure}
/// Thrown during the logout process if a failure occurs.
/// {@endtemplate}
class LogOutFailure extends AuthenticationFailure {
  /// {@macro log_out_failure}
  const LogOutFailure(super.error);
}
