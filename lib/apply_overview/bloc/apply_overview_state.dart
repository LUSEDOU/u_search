part of 'apply_overview_bloc.dart';

enum ApplyOverviewStatus { initial, loading, success, failure }

class ApplyOverviewState extends Equatable {
  const ApplyOverviewState({
    required this.apply,
    this.status = ApplyOverviewStatus.initial,
    this.reviewer,
  });

  final Apply apply;
  final ApplyOverviewStatus status;
  final User? reviewer;

  ApplyOverviewState copyWith({
    Apply? apply,
    ApplyOverviewStatus? status,
    User? Function()? reviewer,
  }) =>
      ApplyOverviewState(
        apply: apply ?? this.apply,
        status: status ?? this.status,
        reviewer: reviewer != null ? reviewer() : this.reviewer,
      );

  @override
  List<Object?> get props => [apply, status, reviewer];
}

extension ApplyOverviewStatusX on ApplyOverviewStatus {
  bool get isInitial => this == ApplyOverviewStatus.initial;
  bool get isLoading => this == ApplyOverviewStatus.loading;
  bool get isSuccess => this == ApplyOverviewStatus.success;
  bool get isFailure => this == ApplyOverviewStatus.failure;
}
