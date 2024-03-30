import 'package:formz/formz.dart';

/// Validation errors for the [ConfirmedPassword] field.
enum ConfirmedPasswordValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template confirmed_password}
/// Formz input for a confirmed password input.
/// {@endtemplate}
class ConfirmedPassword
    extends FormzInput<String, ConfirmedPasswordValidationError> {
  /// {@macro confirmed_password}
  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');

  /// {@macro confirmed_password}
  const ConfirmedPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  /// The password used to validate this field.
  final String password;

  @override
  ConfirmedPasswordValidationError? validator(String? value) {
    return password == value ? null : ConfirmedPasswordValidationError.invalid;
  }
}
