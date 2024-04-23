import 'package:application_repository/application_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:u_search_api/client.dart';

import 'package:u_search_flutter/apply_review/apply_review.dart';

part 'apply_review_event.dart';
part 'apply_review_state.dart';

class ApplyReviewBloc extends Bloc<ApplyReviewEvent, ApplyReviewState> {
  ApplyReviewBloc({
    required ApplicationRepository applicationRepository,
    required Review review,
    required int applyId,
  })  : _applicationRepository = applicationRepository,
        _applyId = applyId,
        super(
          ApplyReviewState(
            review: review,
            calification: CalificationNode.fromReview(review),
            isValid: review.isCreated,
          ),
        ) {
    on<ApplyReviewCommentChanged>(_onCommentChanged);
    on<ApplyReviewScoreChanged>(_onScoreChanged);
    on<ApplyReviewSubmit>(_onSubmit);
  }

  final ApplicationRepository _applicationRepository;
  final int _applyId;

  void _onScoreChanged(
    ApplyReviewScoreChanged event,
    Emitter<ApplyReviewState> emit,
  ) {
    final score = Score.dirty(value: event.score);
    if (!score.isValid) {
      emit(state.copyWith(isValid: false));
    }
    try {
      final (updatedCalification, _) = state.calification.updateScore(
        score: score.numericValue!,
        order: event.order,
      );
      emit(
        state.copyWith(
          calification: updatedCalification,
          isValid: updatedCalification.validate(),
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ApplyReviewStatus.failure));
    }
  }

  void _onCommentChanged(
    ApplyReviewCommentChanged event,
    Emitter<ApplyReviewState> emit,
  ) {
    try {
      final comment = Comment.dirty(value: event.comment);
      final updatedCalification = state.calification.updateComment(
        comment: comment.value,
        order: event.order,
      );
      emit(
        state.copyWith(
          calification: updatedCalification,
          isValid: updatedCalification.validate(),
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(
        state.copyWith(
          status: ApplyReviewStatus.failure,
        ),
      );
    }
  }

  Future<void> _onSubmit(
    ApplyReviewSubmit event,
    Emitter<ApplyReviewState> emit,
  ) async {
    if (!state.isValid) return;
    emit(state.copyWith(status: ApplyReviewStatus.loading));
    try {
      final calification = state.calification.toModels();
      final criterias = state.calification.childrens!;
      await _applicationRepository.review(
        apply: _applyId,
        review: Review(
          id: -1,
          calification: calification,
          criterias: criterias,
        ),
      );
      emit(state.copyWith(status: ApplyReviewStatus.success));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ApplyReviewStatus.failure));
    }
  }
}
