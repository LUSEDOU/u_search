import 'package:application_repository/application_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:u_search_api/api.dart';
import 'package:user_repository/user_repository.dart';

part 'applies_overview_event.dart';
part 'applies_overview_state.dart';

class AppliesOverviewBloc
    extends Bloc<AppliesOverviewEvent, AppliesOverviewState> {
  AppliesOverviewBloc({
    required ApplicationRepository applicationRepository,
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        _applicationRepository = applicationRepository,
        super(const AppliesOverviewState()) {
    on<AppliesOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<AppliesOverviewFetchRequested>(_onFetchRequested);

  }

  final UserRepository _userRepository;
  final ApplicationRepository _applicationRepository;

  Future<void> _onSubscriptionRequested(
    AppliesOverviewSubscriptionRequested event,
    Emitter<AppliesOverviewState> emit,
  ) async {
    emit(state.copyWith(status: AppliesOverviewStatus.loading));
    await _applicationRepository.fetchApplications();

    await emit.forEach<List<Apply>>(
      _applicationRepository.applications,
      onData: (applies) => state.copyWith(
        status: AppliesOverviewStatus.success,
        applies: applies,
      ),
      onError: (error, stackTrace) {
        return state.copyWith(status: AppliesOverviewStatus.failure);
      },
    );
  }

  Future<void> _onFetchRequested(
    AppliesOverviewFetchRequested event,
    Emitter<AppliesOverviewState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AppliesOverviewStatus.loading));
      await _applicationRepository.fetchApplications();
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: AppliesOverviewStatus.failure));
    }
  }
}
