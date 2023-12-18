import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';

part 'apply_event.dart';
part 'apply_state.dart';

class ApplyBloc extends Bloc<ApplyEvent, ApplyState> {
  ApplyBloc({
    required DataRepository dataRepository,
  })  : _dataRepository = dataRepository,
        super(const ApplyState()) {
    on<ApplyFetchContests>(_onFetchContests);
    on<ApplySelectContest>(_onSelectContest);
    on<ApplyUploadResearch>(_onUploadResearch);
    on<ApplySubmitApplication>(_onSubmitApplication);
  }

  final DataRepository _dataRepository;

  Future<void> _onFetchContests(
    ApplyFetchContests event,
    Emitter<ApplyState> emit,
  ) async {
    emit(state.copyWith(status: ApplyStatus.loading));
    try {
      final contests = await _dataRepository.getContests();
      emit(
        state.copyWith(
          contests: contests,
          status: ApplyStatus.success,
        ),
      );
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
      emit(
        state.copyWith(
          selectedContest: event.contest,
          status: ApplyStatus.success,
          step: ApplyStep.research,
        ),
      );
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
      emit(
        state.copyWith(
          file: event.file,
          research: Research(
            researcher: event.researcher,
            length: await event.file.length(),
            title: event.file.path.split('/').last,
            uuid: '',
          ),
          status: ApplyStatus.success,
        ),
      );
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
      final uuid = await _dataRepository.uploadResearchFile(
        research: state.file!,
      );

      final research = await _dataRepository.addResearch(
        state.research!.copyWith(uuid: uuid),
      );

      final apply = await _dataRepository.addApply(
        Apply.empty.copyWith(
          contest: state.selectedContest,
          research: research,
        ),
      );

      emit(
        state.copyWith(
          research: research,
          apply: apply,
          status: ApplyStatus.success,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: ApplyStatus.failure));
    }
  }
}
