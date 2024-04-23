import 'package:formz/formz.dart';

/// Validation errors for the [Score] [FormzInput].
enum ScoreValidationError {
  /// When the score is empty
  empty('Please enter a score'),

  /// When the score is invalid
  invalid('Please enter a valid score'),

  /// When the score is greater than the max score
  greaterThanMax('Score must be less than or equal to the max score');

  /// {@macro score_validation_error}
  const ScoreValidationError(this.message);

  /// The error message to display for the validation error
  final String message;
}

/// {@template score}
/// Form input for the score input.
/// {@endtemplate}
class Score extends FormzInput<String, ScoreValidationError> {
  /// {@macro score}
  const Score.pure({String? score, this.maxScore}) : super.pure(score ?? '');

  /// {@macro score}
  const Score.dirty({String value = '', this.maxScore}) : super.dirty(value);

  /// The max score allowed
  final double? maxScore;

  static const _scoreRegExp = r'^\d(?:\.\d{0,2})?$';

  double? get numericValue => double.tryParse(value);

  @override
  ScoreValidationError? validator(String? value) {
    if (value?.isEmpty ?? true) {
      return ScoreValidationError.empty;
    }
    final score = double.tryParse(value!);
    if (!RegExp(_scoreRegExp).hasMatch(value) || (score ?? 0) < 0) {
      return ScoreValidationError.invalid;
    }
    if (maxScore != null && score! > maxScore!) {
      return ScoreValidationError.greaterThanMax;
    }
    return null;
  }
}
