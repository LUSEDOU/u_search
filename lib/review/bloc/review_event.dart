part of 'review_bloc.dart';

sealed class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object?> get props => [];
}

final class ReviewScoreChanged extends ReviewEvent {
  const ReviewScoreChanged({
    required this.subCriteria,
    required this.score,
  });

  final SubCriteria subCriteria;
  final double? score;

  @override
  List<Object?> get props => [subCriteria, score];
}

final class ReviewCommentChanged extends ReviewEvent {
  const ReviewCommentChanged({
    required this.subCriteria,
    required this.comment,
  });

  final SubCriteria subCriteria;
  final String? comment;

  @override
  List<Object?> get props => [subCriteria, comment];
}

final class ReviewSubmitted extends ReviewEvent {
  const ReviewSubmitted();
}
