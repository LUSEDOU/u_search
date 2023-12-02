import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:u_search_flutter/apply_overview/apply_overview.dart';

part 'apply_overview_state.dart';
part 'apply_overview_event.dart';

class ApplyOverviewBloc extends Bloc<ApplyOverviewEvent, ApplyOverviewState> {
  ApplyOverviewBloc({
    required DataRepository dataRepository,
    Apply? initialApply,
  })  : _dataRepository = dataRepository,
        super(ApplyOverviewState(initialApply: initialApply));

  final DataRepository _dataRepository;

  Future<void> fetchApply(
    ApplyOverviewFetchApply event,
    Emitter<ApplyOverviewState> emit,
  ) async {
    emit(state.copyWith(status: ApplyOverviewStatus.loading));
    try {
      final apply = await _dataRepository.getApply(event.id);
      emit(state.copyWith(
        status: ApplyOverviewStatus.success,
        initialApply: apply,
      ));
    } on Exception {
      emit(state.copyWith(status: ApplyOverviewStatus.failure));
    }
  }
}
