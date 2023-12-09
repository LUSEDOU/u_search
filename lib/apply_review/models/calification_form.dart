import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

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
          percent: percent,
          isValid: isValid,
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

  static CalificationForm fromModel(Calification calification) =>
      CalificationForm._(
        id: calification.subCriteria.id,
        score: Score.pure(
          score: calification.score?.toString() ?? '',
          maxScore: calification.subCriteria.maxScore,
        ),
        comment: Comment.pure(value: calification.comment ?? ''),
        percent: calification.subCriteria.percent,
        isValid: true,
      );

  CalificationForm dirty({
    String? score,
    String? comment,
  }) {
    final scoreForm = score == null
        ? null
        : Score.dirty(
            value: score,
            maxScore: this.score.maxScore,
          );
    final commentForm = comment == null ? null : Comment.dirty(value: comment);

    if (scoreForm == null && commentForm == null) {
      return this;
    }

    late final bool? isValid;
    if (this.score.isPure || this.comment.isPure) {
      isValid = null;
    } else {
      isValid =
          (scoreForm ?? this.score).isValid && commentForm?.isValid == true;
    }

    return CalificationForm._(
      id: id,
      score: score != null
          ? Score.dirty(value: score, maxScore: this.score.maxScore)
          : this.score,
      comment: comment != null ? Comment.dirty(value: comment) : this.comment,
      percent: percent,
      isValid: isValid,
    );
  }

  @override
  String toString() {
    return 'CalificationForm(id: $id, score: $score, comment: $comment, percent: $percent)';
  }

  @override
  List<Object> get props => [id, score, comment, percent];
}

extension CalificationFormX on CalificationForm {
  double get ponderateScore => double.tryParse(score.value) ?? 0 * percent;
}

extension CalificationSearcher<T> on List<CalificationForm> {
  CalificationForm? fromSubCriteria(SubCriteria subCriteria) =>
      firstWhereOrNull(
        (element) => element.id == subCriteria.id,
      );

  List<CalificationForm?> fromCriteria(Criteria criteria) =>
      criteria.subCriterias
          .map((e) => fromSubCriteria(e))
          .toList(growable: false);

  // Return null if any of the CalificationForm is null
  double? scoreFrom(Criteria criteria) {
    final califications = fromCriteria(criteria);
    if (califications.any((element) => element == null)) {
      return null;
    }
    return califications
        .fold<double>(
          0,
          (previousValue, element) => previousValue + element!.ponderateScore,
        )
        .asScore;
  }

  double? totalScore(List<Criteria> criterias) {
    final scores = criterias.map((e) {
      final score = scoreFrom(e);
      if (score == null) {
        return null;
      }
      return score * e.percent;
    }).toList();

    if (scores.any((element) => element == null)) {
      return null;
    }

    return scores
        .fold<double>(
          0,
          (previousValue, element) => previousValue + element!,
        )
        .asScore;
  }

  List<CalificationForm> fromContest(Contest contest) => contest.criterias
      .expand((element) => element.subCriterias)
      .map((e) => CalificationForm.pure(id: e.id, percent: e.percent))
      .toList();

  bool? validate() {
    if (any((e) => e.isValid == null)) {
      return null;
    }
    return every((element) => element.isValid!);
  }

  CalificationForm? firstWhereOrNull(
    bool Function(CalificationForm element) test,
  ) {
    try {
      return firstWhere(test);
    } catch (_) {
      return null;
    }
  }
}

extension CalificationsFormX on Contest {
  List<CalificationForm> get califications => criterias
      .expand((element) => element.subCriterias)
      .map(
        (e) => CalificationForm.pure(
          id: e.id,
          maxScore: e.maxScore,
          percent: e.percent,
        ),
      )
      .toList();
}

extension _ScoreDoubleX on double {
  /// Round double to 2 decimal places
  double get asScore => ((this * 100).round() / 100).toDouble();
}
