import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'apply_event.dart';
part 'apply_state.dart';

class ApplyBloc extends Bloc<ApplyEvent, ApplyState> {
  ApplyBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const ApplyState()) {
    on<ApplyFetchContests>(_onFetchContests);
    on<ApplySelectContest>(_onSelectContest);
    on<ApplyUploadResearch>(_onUploadResearch);
    on<ApplySubmitApplication>(_onSubmitApplication);
  }

  final UserRepository _userRepository;

  Future<void> _onFetchContests(
    ApplyFetchContests event,
    Emitter<ApplyState> emit,
  ) async {
    emit(state.copyWith(status: ApplyStatus.loading));
    try {
      final contests = await _userRepository.getContests();
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
      final uuid = await _userRepository.uploadResearchFile(
        research: state.file!,
      );

      final research = await _userRepository.addResearch(
        state.research!.copyWith(uuid: uuid),
      );

      final apply = await _userRepository.addApply(
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
