part of 'apply_review_bloc.dart';

enum ApplyReviewStatus { initial, validating, loading, success, failure }

class ApplyReviewState extends Equatable {
  const ApplyReviewState({
    required this.review,
    required this.calification,
    this.status = ApplyReviewStatus.initial,
    this.isValid = false,
  });

  final Review review;
  final CalificationNode calification;
  final ApplyReviewStatus status;
  final bool isValid;

  bool get isEditable => !review.isCreated;

  ApplyReviewState copyWith({
    Review? review,
    CalificationNode? calification,
    ApplyReviewStatus? status,
    bool? isValid,
  }) {
    return ApplyReviewState(
      review: review ?? this.review,
      calification: calification ?? this.calification,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [review, calification, status, isValid];
}
