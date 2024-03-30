part of 'user_repository.dart';

/// {@template user_failure}
/// A base failure for the user repository failures.
/// {@endtemplate}
abstract class UserFailure with EquatableMixin implements Exception {
  /// {@macro user_failure}
  const UserFailure(this.error);

  /// The error which was caught.
  final Object error;

  @override
  List<Object> get props => [error];
}

/// {@template send_login_email_link_failure}
/// A failure when sending a login email link.
/// {@endtemplate}
class SendLoginEmailLinkFailure extends UserFailure {
  /// {@macro send_login_email_link_failure}
  const SendLoginEmailLinkFailure(super.error);
}

/// {@template log_in_with_email_link_failure}
/// A failure when logging in with an email link.
/// {@endtemplate}
class LogInWithEmailLinkFailure extends UserFailure {
  /// {@macro log_in_with_email_link_failure}
  const LogInWithEmailLinkFailure(super.error);
}

/// {@template log_out_failure}
/// A failure when logging out.
/// {@endtemplate}
class LogOutFailure extends UserFailure {
  /// {@macro log_out_failure}
  const LogOutFailure(super.error);
}
