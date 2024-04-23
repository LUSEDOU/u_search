part of 'apply_review_bloc.dart';

sealed class ApplyReviewEvent extends Equatable {
  const ApplyReviewEvent();
}

final class ApplyReviewRequested extends ApplyReviewEvent {
  const ApplyReviewRequested();

  @override
  List<Object> get props => [];
}

final class ApplyReviewScoreChanged extends ApplyReviewEvent {
  const ApplyReviewScoreChanged({
    required this.order,
    required this.score,
  });

  final List<int> order;
  final String score;

  @override
  List<Object?> get props => [order, score];
}

final class ApplyReviewCommentChanged extends ApplyReviewEvent {
  const ApplyReviewCommentChanged({
    required this.order,
    required this.comment,
  });

  final List<int> order;
  final String comment;

  @override
  List<Object?> get props => [order, comment];
}

final class ApplyReviewSubmit extends ApplyReviewEvent {
  const ApplyReviewSubmit();

  @override
  List<Object> get props => [];
}
