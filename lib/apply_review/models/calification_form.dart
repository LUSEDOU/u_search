import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';

class CalificationForm extends Equatable {
  const CalificationForm._({
    required this.id,
    this.score = const Score.pure(),
    this.comment = const Comment.pure(),
    this.percent = 1,
    this.isValid,
  });

  CalificationForm.pure({
    required int id,
    double? maxScore,
    double percent = 1,
    bool? isValid,
  }) : this._(
          id: id,
          score: Score.pure(score: '', maxScore: maxScore),
          comment: const Comment.pure(value: ''),
          percent: percent,
          isValid: isValid,
        );

  CalificationForm.fromModel(Calification calification)
      : this._(
          id: calification.subCriteria.id,
          score: Score.pure(
            score: calification.score?.toString() ?? '',
            maxScore: calification.subCriteria.maxScore,
          ),
          comment: Comment.pure(value: calification.comment ?? ''),
          percent: calification.subCriteria.percent,
          isValid: true,
        );

  CalificationForm.fromSubCriteria(SubCriteria subCriteria)
      : this._(
          id: subCriteria.id,
          score: Score.pure(
            maxScore: subCriteria.maxScore,
          ),
          percent: subCriteria.percent,
        );

  final int id;
  final Score score;
  final Comment comment;
  final double percent;
  final bool? isValid;

  Calification get model => Calification(
        subCriteria: SubCriteria(
          id: id,
          percent: percent,
          maxScore: score.maxScore ?? 5,
        ),
        score: double.tryParse(score.value),
        comment: comment.value,
      );

  CalificationForm dirty({
    String? score,
    String? comment,
  }) {
    if (score == null && comment == null) {
      return this;
    }

    final scoreForm = score == null
        ? this.score
        : Score.dirty(
            value: score,
            maxScore: this.score.maxScore,
          );

    final commentForm = comment == null
        ? this.comment
        : Comment.dirty(
            value: comment,
          );

    late final bool? isValid;
    if (scoreForm.isPure || commentForm.isPure) {
      isValid = null;
    } else {
      isValid = scoreForm.isValid && commentForm.isValid;
    }

    return CalificationForm._(
      id: id,
      score: scoreForm,
      comment: commentForm,
      percent: percent,
      isValid: isValid,
    );
  }

  double get ponderateScore => (double.tryParse(score.value) ?? 0) * percent;

  @override
  String toString() {
    return 'CalificationForm(id: $id, score: $score, comment: $comment, percent: $percent)';
  }

  @override
  List<Object> get props => [id, score, comment, percent];
}
