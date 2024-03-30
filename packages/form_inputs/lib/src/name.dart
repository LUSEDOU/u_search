import 'package:formz/formz.dart';

/// Validation errors for the [Name] [FormzInput].
enum NameValidationError {
  /// Generic empty error.
  empty('Please enter a name.'),

  /// Generic invalid error.
  invalid('Please enter a valid name.');

  /// {@macro name_validation_error}
  const NameValidationError(this.message);

  /// The error message to display for the validation error.
  final String message;
}

/// {@template email}
/// Form input for an name input.
/// {@endtemplate}
class Name extends FormzInput<String, NameValidationError> {
  /// {@macro name}
  const Name.pure() : super.pure('');

  /// {@macro name}
  const Name.dirty([super.value = '']) : super.dirty();
  
  @override
  NameValidationError? validator(String? value) {
    if (value?.isEmpty ?? true) {
      return NameValidationError.empty;
    }
    
    return null;
  }
}
