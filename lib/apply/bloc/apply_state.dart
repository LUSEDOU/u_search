part of 'apply_bloc.dart';

enum ApplyStatus { initial, loading, success, failure, finished }

class ApplyState extends Equatable {
  const ApplyState({
    this.contest = Contest.empty,
    this.status = ApplyStatus.initial,
    this.file,
    this.apply = Apply.empty,
  });

  final ApplyStatus status;
  final PlatformFile? file;
  final Contest contest;
  final Apply apply;

  ApplyState copyWith({
    ApplyStatus? status,
    PlatformFile? file,
    Contest? contest,
    Apply? apply,
  }) {
    return ApplyState(
      status: status ?? this.status,
      file: file ?? this.file,
      contest: contest ?? this.contest,
      apply: apply ?? this.apply,
    );
  }

  @override
  List<Object?> get props => [file?.name, status, contest, apply.id];
}
