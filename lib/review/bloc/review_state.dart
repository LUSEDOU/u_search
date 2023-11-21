part of 'review_bloc.dart';

enum ReviewStatus { initial, loading, success, failure }

final class ReviewState extends Equatable {
  const ReviewState({
    required this.apply,
    required this.initialReview,
    this.status = ReviewStatus.initial,
    this.califications = const [],
  });

  final ReviewStatus status;
  final Apply apply;
  final Review? initialReview;
  final List<Calification> califications;

  bool get isNew => initialReview == null;
  Contest get contest => apply.contest;
  List<Criteria> get criterias => contest.criterias;

  Calification calificationFrom(SubCriteria subCriteria) =>
      califications.firstWhere(
        (calification) => calification.subCriteria.id == subCriteria.id,
        orElse: () => Calification(
          subCriteria: subCriteria,
        ),
      );

  double get totalScore {
    double score = 0;

    for (final criteria in criterias) {
      final subScore = scoreFrom(criteria);
      score += subScore * criteria.percent;
    }

    score = double.parse(score.toStringAsFixed(2));
    return score;
  }

  double scoreFrom(Criteria criteria) {
    final subCriterias = criteria.subCriterias;
    double score = 0;

    for (final subCriteria in subCriterias) {
      final calification = calificationFrom(subCriteria);
      if (calification.score != null) {
        score += calification.score! * subCriteria.percent;
      }
      // Max 2 decimals
    }

    score = double.parse(score.toStringAsFixed(2));
    return score;
  }
  // => review.califications
  //     .where(
  //       (calification) => criteria.subCriterias.any(
  //         (subCriteria) => subCriteria.id == calification.subCriteria.id,
  //       ),
  //     )
  //     .fold(0,
  //         (previousValue, calification) => previousValue + (calification.score! * calification) );

  ReviewState copyWith({
    ReviewStatus? status,
    List<Calification>? califications,
    Review? initialReview,
  }) {
    return ReviewState(
      apply: apply,
      status: status ?? this.status,
      initialReview: initialReview ?? this.initialReview,
      califications: califications ?? this.califications,
    );
  }

  @override
  List<Object?> get props => [status, apply, initialReview, califications];
}
