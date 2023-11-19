part of 'review_cubit.dart';

enum ReviewStatus { initial, loading, success, failure }

final class ReviewState extends Equatable {
  final ReviewStatus status;
  final Apply apply;

  Review get review => apply.review!;

  Contest get contest => apply.contest;
  List<Criteria> get criterias => contest.criterias;
  //
  // List<Calification> calificationFrom(SubCriteria subCriteria) => apply
  //     .califications
  //     .where((calification) => calification.subCriteria.id == subCriteria.id)
  //     .toList();
  //
  // int get totalScore => apply.califications.fold(
  //     0, (previousValue, calification) => previousValue + calification.score);
  //
  // int scoreFrom(Criteria criteria) => apply.califications
  //     .where((calification) => criteria.subCriterias
  //         .any((subCriteria) => subCriteria.id == calification.subCriteria.id))
  //     .fold(0,
  //         (previousValue, calification) => previousValue + calification.score);

  const ReviewState({
    required this.apply,
    this.status = ReviewStatus.initial,
  });

  ReviewState copyWith({
    ReviewStatus? status,
    Apply? apply,
  }) {
    return ReviewState(
      status: status ?? this.status,
      apply: apply ?? this.apply,
    );
  }

  @override
  List<Object> get props => [status, apply];
}
