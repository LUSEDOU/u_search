import 'package:application_repository/application_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:u_search_api/api.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

part 'apply_overview_state.dart';
part 'apply_overview_event.dart';

class ApplyOverviewBloc extends Bloc<ApplyOverviewEvent, ApplyOverviewState> {
  ApplyOverviewBloc({
    required ApplicationRepository applicationRepository,
    required Apply apply,
  })  : _applicationRepository = applicationRepository,
        super(ApplyOverviewState(apply: apply, reviewer: apply.reviewer)) {
    on<ApplyOverviewRequested>(_onRequested);
    on<ApplyOverviewReviewerChanged>(_onReviewerChanged);
    on<ApplyOverviewDownloadRequested>(_onDownloadRequested);
    on<ApplyOverviewSubmit>(_onSubmit);
  }

  final ApplicationRepository _applicationRepository;

  Future<void> _onRequested(
    ApplyOverviewRequested event,
    Emitter<ApplyOverviewState> emit,
  ) async {
    emit(state.copyWith(status: ApplyOverviewStatus.loading));
    try {
      final apply = await _applicationRepository.fetchApplication(event.id);
      emit(
        state.copyWith(
          apply: apply,
          status: ApplyOverviewStatus.success,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ApplyOverviewStatus.failure));
    }
  }

  void _onReviewerChanged(
    ApplyOverviewReviewerChanged event,
    Emitter<ApplyOverviewState> emit,
  ) {
    LoggerManager().d(event.reviewer);
    emit(state.copyWith(reviewer: () => event.reviewer));
  }

  Future<void> _onDownloadRequested(
    ApplyOverviewDownloadRequested event,
    Emitter<ApplyOverviewState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ApplyOverviewStatus.loading));
      LoggerManager()
          .d('Downloading research with uuid ${state.apply.research.uuid}');
      await _applicationRepository.downloadResearch(state.apply.research);
      emit(state.copyWith(status: ApplyOverviewStatus.success));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: ApplyOverviewStatus.failure));
      addError(error, stackTrace);
    }
  }

  Future<void> _onSubmit(
    ApplyOverviewSubmit event,
    Emitter<ApplyOverviewState> emit,
  ) async {
    final reviewer = state.reviewer;
    if (reviewer == null) {
      emit(state.copyWith(status: ApplyOverviewStatus.failure));
      return;
    }

    emit(state.copyWith(status: ApplyOverviewStatus.loading));
    try {
      final apply = state.apply.copyWith(reviewer: reviewer);
      final updatedApply = await _applicationRepository.selectReviewer(
        apply: apply,
        reviewer: reviewer,
      );
      emit(
        state.copyWith(
          apply: updatedApply,
          status: ApplyOverviewStatus.success,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ApplyOverviewStatus.failure));
    }
  }
}
