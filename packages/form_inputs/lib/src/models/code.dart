import 'package:formz/formz.dart';

/// Validation errors for the [Code] [FormzInput].
enum CodeValidationError {
  /// Generic empty error.
  empty('Please enter a code.'),

  /// Generic invalid error.
  invalid('Please enter a valid code.');

  /// {@macro code_validation_error}
  const CodeValidationError(this.message);

  /// The error message to display for the validation error.
  final String message;
}

/// {@template email}
/// Form input for an code input.
/// {@endtemplate}
class Code extends FormzInput<String, CodeValidationError> {
  /// {@macro code}
  const Code.pure() : super.pure('');

  /// {@macro code}
  const Code.dirty([super.value = '']) : super.dirty();
  
  @override
  CodeValidationError? validator(String? value) {
    if (value?.isEmpty ?? true) {
      return CodeValidationError.empty;
    }
    
    return null;
  }
}
