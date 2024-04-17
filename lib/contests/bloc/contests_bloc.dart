import 'package:application_repository/application_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:u_search_api/api.dart';

part 'contests_event.dart';
part 'contests_state.dart';

class ContestsBloc extends Bloc<ContestsEvent, ContestsState> {
  ContestsBloc({
    required ApplicationRepository applicationRepository,
  })  : _applicationRepository = applicationRepository,
        super(const ContestsState()) {
    on<ContestsRequested>(_onRequested);
  }

  final ApplicationRepository _applicationRepository;

  Future<void> _onRequested(
    ContestsRequested event,
    Emitter<ContestsState> emit,
  ) async {
    emit(state.copyWith(status: ContestsStatus.loading));
    try {
      final contests = await _applicationRepository.fetchContests();
      emit(state.copyWith(contests: contests, status: ContestsStatus.success));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ContestsStatus.failure));
    }
  }
}
