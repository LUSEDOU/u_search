import 'dart:io';

import 'package:application_repository/application_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:user_repository/user_repository.dart';

part 'apply_event.dart';
part 'apply_state.dart';

class ApplyBloc extends Bloc<ApplyEvent, ApplyState> {
  ApplyBloc({
    required int contest,
    required ApplicationRepository applicationRepository,
  })  : _contest = contest,
        _applicationRepository = applicationRepository,
        super(const ApplyState()) {
    on<ApplyLoadFile>(_onLoadFile);
    on<ApplySubmissionRequested>(_onSubmissionRequested);
  }

  final int _contest;
  final ApplicationRepository _applicationRepository;

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
      final file = File(state.file!.path!);
      await _applicationRepository.apply(
        research: file,
        contest: _contest,
      );
      emit(state.copyWith(status: ApplyStatus.success));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ApplyStatus.failure));
    }
  }
}
