import 'package:formz/formz.dart';

/// Validation errors for the [Email] [FormzInput].
enum EmailValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template email}
/// Form input for an email input.
/// {@endtemplate}
class Email extends FormzInput<String, EmailValidationError> {
  /// {@macro email}
  const Email.pure() : super.pure('');

  /// {@macro email}
  const Email.dirty([super.value = '']) : super.dirty();

  RegExp get _emailRegExp => RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
      );

  @override
  EmailValidationError? validator(String? value) {
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : EmailValidationError.invalid;
  }
}

/// {@template domain_email}
/// Form input for an email input that only allows emails
/// from a specific domain.
/// {@endtemplate}
class DomainEmail extends Email {
  /// {@macro domain_email}
  const DomainEmail.pure() : super.pure();

  /// {@macro domain_email}
  const DomainEmail.dirty([super.value]) : super.dirty();

  @override
  RegExp get _emailRegExp => RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@(usil\.pe|usil\.edu\.pe|epg\.usil\.pe)$',
      );
}
