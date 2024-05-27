import 'dart:io';

import 'package:application_repository/application_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:u_search_api/api.dart';
import 'package:user_repository/user_repository.dart';

part 'apply_event.dart';
part 'apply_state.dart';

class ApplyBloc extends Bloc<ApplyEvent, ApplyState> {
  ApplyBloc({
    required ApplicationRepository applicationRepository,
    Contest? contest,
  })  : _applicationRepository = applicationRepository,
        super(ApplyState(contest: contest ?? Contest.empty)) {
    on<ApplyFetchContest>(_onFetchContest);
    on<ApplyLoadFile>(_onLoadFile);
    on<ApplySubmissionRequested>(_onSubmissionRequested);
  }

  final ApplicationRepository _applicationRepository;

  Future<void> _onFetchContest(
    ApplyFetchContest event,
    Emitter<ApplyState> emit,
  ) async {
    emit(state.copyWith(status: ApplyStatus.loading));
    try {
      final contest =
          await _applicationRepository.fetchContest(event.contestId);
      emit(state.copyWith(contest: contest, status: ApplyStatus.success));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ApplyStatus.failure));
    }
  }

  void _onLoadFile(
    ApplyLoadFile event,
    Emitter<ApplyState> emit,
  ) {
    emit(state.copyWith(file: event.file, status: ApplyStatus.success));
  }

  Future<void> _onSubmissionRequested(
    ApplySubmissionRequested event,
    Emitter<ApplyState> emit,
  ) async {
    emit(state.copyWith(status: ApplyStatus.loading));
    try {
      final apply = await _applicationRepository.apply(
        research: state.file!.bytes!,
        contest: state.contest.id,
        title: state.file!.name,
      );
      emit(state.copyWith(status: ApplyStatus.finished, apply: apply));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ApplyStatus.failure));
    }
  }
}
