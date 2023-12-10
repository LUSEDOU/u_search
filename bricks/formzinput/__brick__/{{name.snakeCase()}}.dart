import 'package:formz/formz.dart';

/// Validation errors for the [{{name.pascalCase()}}] [FormzInput].
enum {{name.pascalCase()}}ValidationError {
  /// Generic empty error.
  empty('Please enter a {{name.snakeCase()}}.'),

  /// Generic invalid error.
  invalid('Please enter a valid {{name.snakeCase()}}.');

  /// {@macro {{name.snakeCase()}}_validation_error}
  const {{name.pascalCase()}}ValidationError(this.message);

  /// The error message to display for the validation error.
  final String message;
}

/// {@template email}
/// Form input for an {{name.snakeCase()}} input.
/// {@endtemplate}
class {{name.pascalCase()}} extends FormzInput<String, {{name.pascalCase()}}ValidationError> {
  /// {@macro {{name.snakeCase()}}}
  const {{name.pascalCase()}}.pure() : super.pure('');

  /// {@macro {{name.snakeCase()}}}
  const {{name.pascalCase()}}.dirty([super.value = '']) : super.dirty();
  {{#hasRegExp}}
  static final RegExp _{{name.camelCase()}}RegExp = RegExp(
    r'^[0-9]{6}$',
  );
  {{/hasRegExp}}
  @override
  {{name.pascalCase()}}ValidationError? validator(String? value) {
    if (value?.isEmpty ?? true) {
      return {{name.pascalCase()}}ValidationError.empty;
    }
    {{#hasRegExp}}
    if (!_{{name.camelCase()}}RegExp.hasMatch(value)) {
      return {{name.pascalCase()}}ValidationError.invalid;
    }
    {{/hasRegExp}}
    return null;
  }
}
