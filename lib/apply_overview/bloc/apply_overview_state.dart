part of 'apply_overview_bloc.dart';

enum ApplyOverviewStatus { initial, loading, success, failure }

class ApplyOverviewState extends Equatable {
  const ApplyOverviewState({
    this.initialApply,
    this.status = ApplyOverviewStatus.initial,
    this.evaluator,
    this.evaluators = const <User>[],
  });

  final Apply? initialApply;
  final ApplyOverviewStatus status;
  final User? evaluator;
  final List<User> evaluators;

  ApplyOverviewState copyWith({
    Apply? initialApply,
    ApplyOverviewStatus? status,
    User? evaluator,
    List<User>? evaluators,
  }) =>
      ApplyOverviewState(
        initialApply: initialApply ?? this.initialApply,
        status: status ?? this.status,
        evaluator: evaluator ?? this.evaluator,
        evaluators: evaluators ?? this.evaluators,
      );

  @override
  List<Object> get props => [];
}
