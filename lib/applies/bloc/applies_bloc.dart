import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_api/u_search_api.dart';
import 'package:u_search_flutter/repositories.dart';

part 'applies_state.dart';
part 'applies_event.dart';

class AppliesBloc extends Bloc<AppliesEvent, AppliesState> {
  AppliesBloc({
    required DataRepository dataRepository,
  })  : _dataRepository = dataRepository,
        super(const AppliesState()) {
    on<AppliesSubscriptionRequested>(_onSubscriptionRequested);
  }

  final DataRepository _dataRepository;

  Future<void> _onSubscriptionRequested(
    AppliesSubscriptionRequested event,
    Emitter<AppliesState> emit,
  ) async {
    emit(state.copyWith(status: AppliesStatus.loading));

    await emit.forEach<List<Apply>>(
      _dataRepository.getApplies(),
      onData: (applies) => state.copyWith(
        status: AppliesStatus.success,
        applies: applies,
      ),
      onError: (error, stackTrace) =>
          state.copyWith(status: AppliesStatus.failure),
    );
  }
}
