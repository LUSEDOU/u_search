import 'package:application_repository/application_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:u_search_api/api.dart';

part 'contest_event.dart';
part 'contest_state.dart';

class ContestBloc extends Bloc<ContestEvent, ContestState> {
  ContestBloc({
    required ApplicationRepository applicationRepository,
    Contest? contest,
  })  : _applicationRepository = applicationRepository,
        super(ContestState(contest: contest ?? Contest.empty)) {
    on<ContestRequested>(_onRequested);
  }

  final ApplicationRepository _applicationRepository;

  Future<void> _onRequested(
    ContestRequested event,
    Emitter<ContestState> emit,
  ) async {
    emit(state.copyWith(status: ContestStatus.loading));
    try {
      final contest = await _applicationRepository.fetchContest(event.id);
      emit(state.copyWith(contest: contest, status: ContestStatus.success));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ContestStatus.failure));
    }
  }
}
