part of 'apply_bloc.dart';

sealed class ApplyEvent extends Equatable {
  const ApplyEvent();

  @override
  List<Object> get props => [];
}

final class ApplyLoadFile extends ApplyEvent {
  const ApplyLoadFile({
    required this.file,
  });

  final File file;

  @override
  List<Object> get props => [file];
}

final class ApplySubmissionRequested extends ApplyEvent {
  const ApplySubmissionRequested();
}
