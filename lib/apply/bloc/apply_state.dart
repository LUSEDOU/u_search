part of 'apply_bloc.dart';

enum ApplyStatus { initial, loading, success, failure }

enum ApplyStep { contest, research }

class ApplyState extends Equatable {
  const ApplyState({
    this.status = ApplyStatus.initial,
    this.file,
    this.research,
    this.selectedContest,
    this.contests = const <Contest>[],
    this.step = ApplyStep.contest,
    this.apply,
  });

  final File? file;
  final Research? research;
  final Contest? selectedContest;
  final List<Contest> contests;
  final ApplyStatus status;
  final ApplyStep step;
  final Apply? apply;

  ApplyState copyWith({
    File? file,
    Research? research,
    Contest? selectedContest,
    List<Contest>? contests,
    ApplyStatus? status,
    ApplyStep? step,
    Apply? apply,
  }) {
    return ApplyState(
      file: file ?? this.file,
      research: research ?? this.research,
      selectedContest: selectedContest ?? this.selectedContest,
      contests: contests ?? this.contests,
      status: status ?? this.status,
      step: step ?? this.step,
      apply: apply ?? this.apply,
    );
  }

  @override
  List<Object?> get props => [
        file,
        research,
        selectedContest,
        contests,
        status,
        step,
        apply,
      ];
}
