import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';

part 'apply_overview_state.dart';
part 'apply_overview_event.dart';

class ApplyOverviewBloc extends Bloc<ApplyOverviewEvent, ApplyOverviewState> {
  ApplyOverviewBloc({
    required DataRepository dataRepository,
    Apply? apply,
  })  : _dataRepository = dataRepository,
        super(ApplyOverviewState(apply: apply)) {
    on<ApplyOverviewFetchApply>(_onFetchApply);
  }

  final DataRepository _dataRepository;

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
}
