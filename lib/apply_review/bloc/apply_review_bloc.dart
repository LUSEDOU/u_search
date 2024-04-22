import 'package:application_repository/application_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:u_search_api/client.dart';

import 'package:u_search_flutter/apply_review/apply_review.dart';
import 'package:u_search_flutter/utils/dart_extensions.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

part 'apply_review_event.dart';
part 'apply_review_state.dart';

class Node {
  const Node(this.parent, this.order);
  final Node? parent;
  final int order;
}

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
            calification: review.calification,
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
    try {
      Node? node = event.node;
      final score = event.score;

      final List<int> orders = [];
      while (node != null) {
        orders.add(node.order);
        node = node.parent;
      }

      while (orders.isNotEmpty) {
        final order = orders.removeLast();

        emit(
          state.copyWith(
            calification: updatedCalification,
            isValid: updatedCalification.isValid,
          ),
        );
      }
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(
        state.copyWith(
          status: ApplyReviewStatus.failure,
        ),
      );
    }
  }

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
      final review = await _applicationRepository.addReview(
        (state.initialReview ?? Review.empty).copyWith(
          califications: state.califications.map((e) => e.model).toList(),
        ),
      );

      final apply = await _applicationRepository.updateApply(
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
