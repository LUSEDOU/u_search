part of 'apply_bloc.dart';

enum ApplyStatus { initial, loading, success, failure }

enum ApplyStep { contest, research }

class ApplyState extends Equatable {
  const ApplyState({
    required this.applicantId,
    this.status = ApplyStatus.initial,
    this.research,
    this.selectedContest,
    this.contests = const <Contest>[],
    this.step = ApplyStep.contest,
  });

  final File? research;
  final Contest? selectedContest;
  final List<Contest> contests;
  final int applicantId;
  final ApplyStatus status;
  final ApplyStep step;

  ApplyState copyWith({
    File? research,
    Contest? selectedContest,
    List<Contest>? contests,
    ApplyStatus? status,
    ApplyStep? step,
  }) {
    return ApplyState(
      research: research ?? this.research,
      selectedContest: selectedContest ?? this.selectedContest,
      contests: contests ?? this.contests,
      status: status ?? this.status,
      applicantId: applicantId,
      step: step ?? this.step,
    );
  }

  @override
  List<Object?> get props => [
        research,
        selectedContest,
        contests,
        status,
        step,
      ];
}
