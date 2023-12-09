part of 'apply_review_bloc.dart';

enum ApplyReviewStatus { initial, loading, success, failure }

class ApplyReviewState extends Equatable {
  const ApplyReviewState({
    required this.apply,
    this.initialReview,
    this.status = ApplyReviewStatus.initial,
    this.califications = const [],
    this.isValid,
  });

  bool get isNew => initialReview == null;

  final Apply apply;
  final Review? initialReview;
  final ApplyReviewStatus status;
  final List<CalificationForm> califications;
  final bool? isValid;

  ApplyReviewState copyWith({
    Apply? apply,
    Review? initialReview,
    ApplyReviewStatus? status,
    List<CalificationForm>? califications,
    bool? isValid,
  }) =>
      ApplyReviewState(
        apply: apply ?? this.apply,
        initialReview: initialReview ?? this.initialReview,
        status: status ?? this.status,
        isValid: isValid ?? this.isValid,
        califications: califications ?? this.califications,
      );

  @override
  List<Object?> get props =>
      [apply, initialReview, status, califications, isValid];
}

extension ApplyReviewStateX on ApplyReviewState {
  bool get isLoading => status == ApplyReviewStatus.loading;
  bool get isSuccess => status == ApplyReviewStatus.success;
  bool get isFailure => status == ApplyReviewStatus.failure;
  bool get isInitial => status == ApplyReviewStatus.initial;
}
