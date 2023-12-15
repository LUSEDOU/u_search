part of 'apply_overview_bloc.dart';

enum ApplyOverviewStatus { initial, loading, success, failure }

class ApplyOverviewState extends Equatable {
  const ApplyOverviewState({
    this.apply,
    this.status = ApplyOverviewStatus.initial,
    this.reviewer,
    this.evaluators = const <Role>[],
  });

  final Apply? apply;
  final ApplyOverviewStatus status;
  final Role? reviewer;
  final List<Role> evaluators;

  ApplyOverviewState copyWith({
    Apply? apply,
    ApplyOverviewStatus? status,
    Role? Function()? reviewer,
    List<Role>? evaluators,
  }) =>
      ApplyOverviewState(
        apply: apply ?? this.apply,
        status: status ?? this.status,
        reviewer: reviewer?.call() ?? this.reviewer,
        evaluators: evaluators ?? this.evaluators,
      );

  @override
  List<Object?> get props => [apply, status, reviewer, evaluators];
}

extension ApplyOverviewStatusX on ApplyOverviewStatus {
  bool get isInitial => this == ApplyOverviewStatus.initial;
  bool get isLoading => this == ApplyOverviewStatus.loading;
  bool get isSuccess => this == ApplyOverviewStatus.success;
  bool get isFailure => this == ApplyOverviewStatus.failure;
}
