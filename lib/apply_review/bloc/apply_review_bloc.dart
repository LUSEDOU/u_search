import 'package:application_repository/application_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:u_search_api/client.dart';

import 'package:u_search_flutter/apply_review/apply_review.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

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
    on<ApplyReviewRequested>(_onRequested);
    on<ApplyReviewCommentChanged>(_onCommentChanged, transformer: sequential());
    on<ApplyReviewScoreChanged>(_onScoreChanged, transformer: sequential());
    on<ApplyReviewSubmit>(_onSubmit, transformer: droppable());
  }

  final ApplicationRepository _applicationRepository;
  final int _applyId;

  Future<void> _onRequested(
    ApplyReviewRequested event,
    Emitter<ApplyReviewState> emit,
  ) async {
    emit(state.copyWith(status: ApplyReviewStatus.loading));
    try {
      final review = await _applicationRepository.fetchReview(_applyId);
      // LoggerManager().i('Review is created: ${review.isCreated}');
      // LoggerManager().i(review.toJson());
      // final calification = CalificationNode.fromReview(review);
      // LoggerManager().i(calification.toJson());
      emit(
        state.copyWith(
          review: review,
          calification: CalificationNode.fromReview(review),
          isValid: review.isCreated,
          status: ApplyReviewStatus.initial,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ApplyReviewStatus.failure));
    }
  }

  void _onScoreChanged(
    ApplyReviewScoreChanged event,
    Emitter<ApplyReviewState> emit,
  ) {
    // if (!score.isValid) {
    //   emit(state.copyWith(isValid: false));
    //   return;
    // }

    try {
      // LoggerManager().d(state.calification.toJson());
      final (updatedCalification, _) = state.calification.updateScore(
        score: double.tryParse(event.score),
        order: event.order,
      );
      // LoggerManager().i(updatedCalification.toJson());
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
    LoggerManager().i('Submit event');
    LoggerManager().i('State is valid: ${state.isValid}');
    if (!state.isValid) return;
    emit(state.copyWith(status: ApplyReviewStatus.loading));
    LoggerManager().i('Submitting review...');
    try {
      final calification = state.calification.toModels();
      final criterias = state.calification.children;
      final review = await _applicationRepository.review(
        apply: _applyId,
        review: Review(
          id: -1,
          calification: calification,
          criterias: criterias!,
        ),
      );
      emit(
        state.copyWith(
          status: ApplyReviewStatus.success,
          review: review,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ApplyReviewStatus.failure));
    }
  }
}
