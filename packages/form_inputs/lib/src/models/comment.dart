import 'package:formz/formz.dart';

/// Validation error for [Comment].
enum CommentValidationError {
  /// Generic invalid error.
  empty('Please enter a comment');

  /// {@macro comment_validation_error}
  const CommentValidationError(this.message);

  /// The error message to display for the validation error.
  final String message;
}

/// {@template comment}
/// Form input for a comment input.
/// {@endtemplate}
class Comment extends FormzInput<String, CommentValidationError> {
  /// {@macro comment}
  const Comment.pure({String value = ''}) : super.pure(value);

  /// {@macro comment}
  const Comment.dirty({String value = ''}) : super.dirty(value);

  @override
  CommentValidationError? validator(String value) {
    return value.isNotEmpty ? null : CommentValidationError.empty;
  }
}
