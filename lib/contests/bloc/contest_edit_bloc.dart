import 'package:application_repository/application_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:u_search_api/client.dart';

import 'package:u_search_flutter/contests/contests.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

part 'contest_edit_event.dart';
part 'contest_edit_state.dart';

class ContestEditBloc extends Bloc<ContestEditEvent, ContestEditState> {
  ContestEditBloc({
    required ApplicationRepository applicationRepository,
  })  : _applicationRepository = applicationRepository,
        super(const ContestEditState()) {
    on<ContestEditRequested>(_onRequested);
  }

  final ApplicationRepository _applicationRepository;

  Future<void> _onRequested(
    ContestEditRequested event,
    Emitter<ContestEditState> emit,
  ) async {
    emit(state.copyWith(status: ContestEditStatus.loading));
    try {
      emit(
        state.copyWith(
          status: ContestEditStatus.initial,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ContestEditStatus.failure));
    }
  }
}
