import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

part 'applies_overview_event.dart';
part 'applies_overview_state.dart';

class AppliesOverviewBloc
    extends Bloc<AppliesOverviewEvent, AppliesOverviewState> {
  AppliesOverviewBloc({
    required DataRepository dataRepository,
  })  : _dataRepository = dataRepository,
        super(const AppliesOverviewState()) {
    on<AppliesOverviewSubscriptionRequested>(_onSubscriptionRequested);
  }

  final DataRepository _dataRepository;

  Future<void> _onSubscriptionRequested(
    AppliesOverviewSubscriptionRequested event,
    Emitter<AppliesOverviewState> emit,
  ) async {
    emit(state.copyWith(status: AppliesOverviewStatus.loading));

    await emit.forEach<List<Apply>>(
      await _dataRepository.getApplies(role: event.role),
      onData: (applies) => state.copyWith(
        status: AppliesOverviewStatus.success,
        applies: applies,
      ),
      onError: (error, stackTrace) {
        LoggerManager().logger
          ..e(error)
          ..e(stackTrace);
        return state.copyWith(status: AppliesOverviewStatus.failure);
      },
    );

    emit(state.copyWith(status: AppliesOverviewStatus.success));
  }
}
