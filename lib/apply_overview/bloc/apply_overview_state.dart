part of 'apply_overview_bloc.dart';

enum ApplyOverviewStatus { initial, loading, success, failure }

class ApplyOverviewState extends Equatable {
  const ApplyOverviewState({
    this.apply,
    this.status = ApplyOverviewStatus.initial,
    this.evaluator,
    this.evaluators = const <User>[],
  });

  final Apply? apply;
  final ApplyOverviewStatus status;
  final User? evaluator;
  final List<User> evaluators;

  ApplyOverviewState copyWith({
    Apply? apply,
    ApplyOverviewStatus? status,
    User? evaluator,
    List<User>? evaluators,
  }) =>
      ApplyOverviewState(
        apply: apply ?? this.apply,
        status: status ?? this.status,
        evaluator: evaluator ?? this.evaluator,
        evaluators: evaluators ?? this.evaluators,
      );

  @override
  List<Object?> get props => [apply, status, evaluator, evaluators];
}

extension ApplyOverviewStatusX on ApplyOverviewStatus {
  bool get isInitial => this == ApplyOverviewStatus.initial;
  bool get isLoading => this == ApplyOverviewStatus.loading;
  bool get isSuccess => this == ApplyOverviewStatus.success;
  bool get isFailure => this == ApplyOverviewStatus.failure;
}
