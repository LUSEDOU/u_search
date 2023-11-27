import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';

part 'apply_event.dart';
part 'apply_state.dart';

class ApplyBloc extends Bloc<ApplyEvent, ApplyState> {
  ApplyBloc({
    required DataRepository dataRepository,
    required int applicantId,
  })  : _dataRepository = dataRepository,
        super(ApplyState(applicantId: applicantId)) {
    on<ApplyEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  final DataRepository _dataRepository;

  Future<void> _onFetchContests(
    ApplyFetchContests event,
    Emitter<ApplyState> emit,
  ) async {
    emit(state.copyWith(status: ApplyStatus.loading));
    try {
      final contests = await _dataRepository.getContests();
      emit(state.copyWith(
        contests: contests,
        status: ApplyStatus.success,
      ));
    } on Exception {
      emit(state.copyWith(status: ApplyStatus.failure));
    }
  }

  Future<void> _onSelectContest(
    ApplySelectContest event,
    Emitter<ApplyState> emit,
  ) async {
    emit(state.copyWith(status: ApplyStatus.loading));
    try {
      emit(state.copyWith(
        selectedContest: event.contest,
        status: ApplyStatus.success,
      ));
    } on Exception {
      emit(state.copyWith(status: ApplyStatus.failure));
    }
  }

  Future<void> _onUploadResearch(
    ApplyUploadResearch event,
    Emitter<ApplyState> emit,
  ) async {
    emit(state.copyWith(status: ApplyStatus.loading));
    try {
      emit(state.copyWith(
        research: event.research,
        status: ApplyStatus.success,
      ));
    } on Exception {
      emit(state.copyWith(status: ApplyStatus.failure));
    }
  }

  Future<void> _onSubmitApplication(
    ApplySubmitApplication event,
    Emitter<ApplyState> emit,
  ) async {
    emit(state.copyWith(status: ApplyStatus.loading));
    try {
      final urlResearch = await _dataRepository.uploadResearch(
        applicantId: state.applicantId,
        research: state.research!,
      );
      final apply = Apply(
        contest: state.selectedContest!,
        research: urlResearch,
      );
    } on Exception {
      emit(state.copyWith(status: ApplyStatus.failure));
    }
  }
}
