import 'package:application_repository/application_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:u_search_flutter/utils/models_extensions.dart';
import 'package:user_repository/user_repository.dart';

part 'apply_overview_state.dart';
part 'apply_overview_event.dart';

class ApplyOverviewBloc extends Bloc<ApplyOverviewEvent, ApplyOverviewState> {
  ApplyOverviewBloc({
    required ApplicationRepository applicationRepository,
    Apply? apply,
  })  : _applicationRepository = applicationRepository,
        super(
          ApplyOverviewState(
            apply: apply,
            reviewer: apply?.reviewer,
          ),
        ) {
    on<ApplyOverviewFetchApply>(_onFetchApply);
    on<ApplyOverviewFetchEvaluators>(_onFetchEvaluaators);
    on<ApplyOverviewSelectEvaluator>(_onSelectEvaluator);
    on<ApplyOverviewSubmit>(_onSubmit);
    on<ApplyOverviewDeleteEvaluator>(_onDeleteEvaluator);
  }

  final ApplicationRepository _applicationRepository;

  Future<void> _onRequested(
    ApplyOverviewRequested event,
    Emitter<ApplyOverviewState> emit,
  ) async {
    emit(state.copyWith(status: ApplyOverviewStatus.loading));
    try {
      await _applicationRepository.getApply(event.id);
    } on Exception {
      emit(state.copyWith(status: ApplyOverviewStatus.failure));
    }
  }

  Future<void> _onFetchApply(
    ApplyOverviewFetchApply event,
    Emitter<ApplyOverviewState> emit,
  ) async {
    emit(state.copyWith(status: ApplyOverviewStatus.loading));
    try {
      final apply = await _dataRepository.getApply(event.id);
      emit(
        state.copyWith(
          status: ApplyOverviewStatus.success,
          apply: apply,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: ApplyOverviewStatus.failure));
    }
  }

  Future<void> _onFetchEvaluaators(
    ApplyOverviewFetchEvaluators event,
    Emitter<ApplyOverviewState> emit,
  ) async {
    emit(state.copyWith(status: ApplyOverviewStatus.loading));
    try {
      final evaluators = await _dataRepository.getEvaluators();
      emit(
        state.copyWith(
          status: ApplyOverviewStatus.success,
          evaluators: evaluators,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: ApplyOverviewStatus.failure));
    }
  }

  void _onSelectEvaluator(
    ApplyOverviewSelectEvaluator event,
    Emitter<ApplyOverviewState> emit,
  ) {
    emit(
      state.copyWith(
        reviewer: () => event.reviewer,
      ),
    );
  }

  Future<void> _onSubmit(
    ApplyOverviewSubmit event,
    Emitter<ApplyOverviewState> emit,
  ) async {
    if (state.reviewer == null) {
      emit(state.copyWith(status: ApplyOverviewStatus.failure));
      return;
    }

    emit(state.copyWith(status: ApplyOverviewStatus.loading));
    try {
      final apply = state.apply!.copyWith(
        reviewer: state.reviewer!.toReviewer(),
      );
      final updatedApply = await _dataRepository.updateApply(apply);
      emit(
        state.copyWith(
          status: ApplyOverviewStatus.success,
          apply: updatedApply,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: ApplyOverviewStatus.failure));
    }
  }

  void _onDeleteEvaluator(
    ApplyOverviewDeleteEvaluator event,
    Emitter<ApplyOverviewState> emit,
  ) {
    emit(
      state.copyWith(
        reviewer: () => null,
      ),
    );
  }
}
