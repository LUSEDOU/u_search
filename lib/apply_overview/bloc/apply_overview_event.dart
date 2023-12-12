part of 'apply_overview_bloc.dart';

sealed class ApplyOverviewEvent extends Equatable {
  const ApplyOverviewEvent();
}

final class ApplyOverviewFetchApply extends ApplyOverviewEvent {
  const ApplyOverviewFetchApply({
      required this.id,
  });

  final int id;

  @override
  List<Object> get props => [id];
}

final class ApplyOverviewFetchEvaluators extends ApplyOverviewEvent {
  const ApplyOverviewFetchEvaluators();


  @override
  List<Object> get props => [];
}

final class ApplyOverviewSelectEvaluator extends ApplyOverviewEvent {
  const ApplyOverviewSelectEvaluator({
      required this.evaluator,
  });

  final User evaluator;

  @override
  List<Object> get props => [evaluator];
}
