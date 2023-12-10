part of 'apply_review_bloc.dart';

sealed class ApplyReviewEvent extends Equatable {
  const ApplyReviewEvent();
}

final class ApplyReviewScoreChanged extends ApplyReviewEvent {
  const ApplyReviewScoreChanged({
    required this.id,
    required this.score,
  });

  final int id;
  final String? score;

  @override
  List<Object?> get props => [id, score];
}

final class ApplyReviewCommentChanged extends ApplyReviewEvent {
  const ApplyReviewCommentChanged({
    required this.id,
    required this.comment,
  });

  final int id;
  final String comment;

  @override
  List<Object?> get props => [id, comment];
}

final class ApplyReviewSubmit extends ApplyReviewEvent {
  const ApplyReviewSubmit();

  @override
  List<Object> get props => [];
}
