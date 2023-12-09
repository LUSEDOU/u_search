import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:u_search_flutter/apply_review/apply_review.dart';
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
                apply.contest.califications,
            isValid: apply.review == null ? null : true,
          ),
        ) {
    on<ApplyReviewCommentChanged>(_onCommentChanged);
    on<ApplyReviewScoreChanged>(_onScoreChanged);
  }

  final DataRepository _dataRepository;

  void _onCommentChanged(
    ApplyReviewCommentChanged event,
    Emitter<ApplyReviewState> emit,
  ) {
    try {
      CalificationForm calification =
          state.califications.firstWhere((element) => element.id == event.id);

      final updatedCalifications =
          List<CalificationForm>.from(state.califications);

      updatedCalifications.remove(calification);

      calification = calification.dirty(comment: event.comment);

      updatedCalifications.add(calification);

      emit(
        state.copyWith(
            califications: updatedCalifications,
            isValid: updatedCalifications.validate()),
      );
    } catch (e) {
      LoggerManager().logger.e(e);
      emit(
        state.copyWith(status: ApplyReviewStatus.failure),
      );
    }
  }

  void _onScoreChanged(
    ApplyReviewScoreChanged event,
    Emitter<ApplyReviewState> emit,
  ) {
    try {
      CalificationForm? calification = state.califications
          .firstWhereOrNull((element) => element.id == event.id);

      if (calification == null) {
        final subCriteria = state.apply.contest.criterias
            .expand((element) => element.subCriterias)
            .toList()
            .firstWhere((element) => element.id == event.id);

        calification = CalificationForm.pure(
          id: subCriteria.id,
          maxScore: subCriteria.maxScore,
        );
      }

      final updatedCalifications =
          List<CalificationForm>.from(state.califications);

      updatedCalifications.remove(calification);

      calification = calification.dirty(score: event.score);

      updatedCalifications.add(calification);

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
}

// class ApplyReviewBloc extends Bloc<ApplyReviewEvent, ApplyReviewState> {
//   ApplyReviewBloc({
//     required DataRepository dataRepository,
//     Apply? apply,
//   })  : _dataRepository = dataRepository,
//         super(
//           apply == null
//               ? const ApplyReviewInitial()
//               : apply.review == null
//                   ? ApplyReviewEditing(
//                       apply: apply,
//                       califications: apply.contest.califications,
//                     )
//                   : ApplyReviewViewing(apply: apply),
//         ) {
//     on<ApplyReviewFetchApply>(_onFetchApply);
//     on<ApplyReviewScoreChanged>(_onScoreChanged);
//     on<ApplyReviewCommentChanged>(_onCommentChanged);
//   }
//
//   final DataRepository _dataRepository;
//
//   Future<void> _onFetchApply(
//     ApplyReviewFetchApply event,
//     Emitter<ApplyReviewState> emit,
//   ) async {
//     emit(const ApplyReviewLoading());
//     try {
//       final apply = await _dataRepository.getApply(event.id);
//
//       if (apply.review != null) {
//         emit(ApplyReviewViewing(apply: apply));
//       } else {
//         final califications = apply.contest.califications;
//         LoggerManager().logger.i(califications);
//         emit(
//           ApplyReviewEditing(
//             apply: apply,
//             califications: apply.contest.califications,
//           ),
//         );
//       }
//     } on Exception {
//       emit(const ApplyReviewFailure());
//     }
//   }
//
//   void _onScoreChanged(ApplyReviewScoreChanged event, Emitter emit) {
//     final state = this.state as ApplyReviewEditing;
//     final calification = state.califications.firstWhere(
//       (element) => element.id == event.id,
//     );
//
//     emit(
//       state.copyWith(
//         califications: [
//           ...state.califications
//             ..removeWhere((element) => element.id == event.id)
//             ..add(calification.dirty(score: event.score)),
//         ],
//       ),
//     );
//   }
//
//   void _onCommentChanged(ApplyReviewCommentChanged event, Emitter emit) {
//     try {
//       if (this.state is! ApplyReviewEditing) {
//         throw Exception('Invalid state');
//       }
//
//       final state = this.state as ApplyReviewEditing;
//
//       final calification = state.califications.firstWhere(
//         (element) => element.id == event.id,
//         orElse: () => throw Exception('Calification not found'),
//       );
//
//       final califications = [
//         ...state.califications
//           ..removeWhere((element) => element.id == event.id)
//           ..add(
//             calification.dirty(comment: event.comment),
//           ),
//       ];
//
//       emit(
//         state.copyWith(
//           califications: califications,
//           isValid: califications.every((element) => element.isValid),
//         ),
//       );
//     } on Exception catch (e) {
//       emit(
//         ApplyReviewFailure(
//           message: e.toString(),
//         ),
//       );
//     }
//   }
// }
