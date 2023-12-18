import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:u_search_flutter/apply_review/apply_review.dart';
import 'package:u_search_flutter/utils/dart_extensions.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

part 'apply_review_event.dart';
part 'apply_review_state.dart';

class ApplyReviewBloc extends Bloc<ApplyReviewEvent, ApplyReviewState> {
  ApplyReviewBloc({
    required DataRepository dataRepository,
    required Apply apply,
  })  : _dataRepository = dataRepository,
        super(
          ApplyReviewState(
            apply: apply,
            initialReview: apply.review,
            califications: apply.review?.califications
                    .map(CalificationForm.fromModel)
                    .toList() ??
                List<CalificationForm>.from(
                  apply.contest.criterias
                      .expand((element) => element.subCriterias)
                      .map(CalificationForm.fromSubCriteria),
                ),
            isValid: apply.review == null ? null : true,
          ),
        ) {
    on<ApplyReviewCommentChanged>(_onCommentChanged);
    on<ApplyReviewScoreChanged>(_onScoreChanged);
    on<ApplyReviewSubmit>(_onSubmit);
  }

  final DataRepository _dataRepository;

  void _onCommentChanged(
    ApplyReviewCommentChanged event,
    Emitter<ApplyReviewState> emit,
  ) {
    try {
      final calification = state.califications.firstWhereOrNull(
              (calification) => calification.id == event.id) ??
          CalificationForm.fromSubCriteria(
            state.apply.contest.criterias
                .expand((element) => element.subCriterias)
                .firstWhere((element) => element.id == event.id),
          );

      final updatedCalifications = List<CalificationForm>.from(
        state.califications,
      )
        ..removeWhere((element) => element.id == event.id)
        ..add(
          calification.dirty(comment: event.comment),
        );

      emit(
        state.copyWith(
          califications: updatedCalifications,
          isValid: updatedCalifications.validate(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ApplyReviewStatus.failure,
        ),
      );
    }
  }

  void _onScoreChanged(
    ApplyReviewScoreChanged event,
    Emitter<ApplyReviewState> emit,
  ) {
    try {
      final calification = state.califications.firstWhereOrNull(
              (calification) => calification.id == event.id) ??
          CalificationForm.fromSubCriteria(
            state.apply.contest.criterias
                .expand((element) => element.subCriterias)
                .firstWhere((element) => element.id == event.id),
          );

      final updatedCalifications = List<CalificationForm>.from(
        state.califications,
      )
        ..removeWhere((element) => element.id == event.id)
        ..add(
          calification.dirty(score: event.score),
        );

      emit(
        state.copyWith(
          califications: updatedCalifications,
          isValid: updatedCalifications.validate(),
        ),
      );
    } catch (e) {
      LoggerManager().logger.e(e);
      emit(
        state.copyWith(status: ApplyReviewStatus.failure),
      );
    }
  }

  void _onSubmit(
    ApplyReviewSubmit event,
    Emitter<ApplyReviewState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ApplyReviewStatus.loading,
      ),
    );

    try {
      final review = await _dataRepository.addReview(
        (state.initialReview ?? Review.empty).copyWith(
          califications: state.califications.map((e) => e.model).toList(),
        ),
      );

      final apply = await _dataRepository.updateApply(
        state.apply.copyWith(
          review: review,
        ),
      );

      emit(
        state.copyWith(
          apply: apply,
          initialReview: review,
          status: ApplyReviewStatus.success,
        ),
      );
    } catch (e) {
      LoggerManager().logger.e(e);
      emit(
        state.copyWith(
          status: ApplyReviewStatus.failure,
        ),
      );
    }
  }
}
