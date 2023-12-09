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
  List<Object?> get props => [apply, initialReview, status, califications];
}

extension ApplyReviewStateX on ApplyReviewState {
  bool get isLoading => status == ApplyReviewStatus.loading;
  bool get isSuccess => status == ApplyReviewStatus.success;
  bool get isFailure => status == ApplyReviewStatus.failure;
  bool get isInitial => status == ApplyReviewStatus.initial;

}

// extension ApplyReviewStateX on ApplyReviewState {
//   bool get isNew => this is ApplyReviewEditing;
//   bool get isLoading => this is ApplyReviewLoading;
//   bool get isSuccess => this is ApplyReviewViewing;
//   bool get isFailure => this is ApplyReviewFailure;
//   bool get isInitial => this is ApplyReviewInitial;
//   bool get isEditing => this is ApplyReviewEditing;
// }
//
// final class ApplyReviewInitial extends ApplyReviewState {
//   const ApplyReviewInitial();
//
//   @override
//   List<Object> get props => const [];
// }
//
// final class ApplyReviewLoading extends ApplyReviewState {
//   const ApplyReviewLoading();
//
//   @override
//   List<Object> get props => const [];
// }
//
// sealed class ApplyReviewFinished extends ApplyReviewState {
//   const ApplyReviewFinished({
//     required this.apply,
//     this.califications = const [],
//   });
//
//   final Apply apply;
//   final List<CalificationForm> califications;
// }
//
// final class ApplyReviewViewing extends ApplyReviewFinished {
//   const ApplyReviewViewing({
//     required super.apply,
//   });
//
//   Review get review => apply.review!;
//
//   @override
//   List<CalificationForm> get califications => review.califications
//       .map(
//         (e) => CalificationForm.fromModel(e),
//       )
//       .toList();
//
//   @override
//   List<Object> get props => [apply];
// }
//
// final class ApplyReviewEditing extends ApplyReviewFinished {
//   const ApplyReviewEditing({
//     required super.apply,
//     required super.califications,
//     this.isValid = false,
//     this.status = FormzSubmissionStatus.initial,
//   });
//
//   final bool isValid;
//   final FormzSubmissionStatus status;
//
//   ApplyReviewEditing copyWith({
//     List<CalificationForm>? califications,
//     bool? isValid,
//     FormzSubmissionStatus? status,
//   }) =>
//       ApplyReviewEditing(
//         apply: apply,
//         califications: califications ?? this.califications,
//         isValid: isValid ?? this.isValid,
//         status: status ?? this.status,
//       );
//
//   @override
//   List<Object> get props => [apply, califications, isValid, status];
// }
//
// final class ApplyReviewFailure extends ApplyReviewState {
//   const ApplyReviewFailure({
//     this.message,
//   });
//
//   final String? message;
//
//   @override
//   List<Object?> get props => [message];
// }
