part of 'apply_overview_bloc.dart';

sealed class ApplyOverviewEvent extends Equatable {
  const ApplyOverviewEvent();
}

final class ApplyOverviewRequested extends ApplyOverviewEvent {
  const ApplyOverviewRequested({required this.id});
  final int id;

  @override
  List<Object> get props => [id];
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
    required this.reviewer,
  });

  final Role reviewer;

  @override
  List<Object> get props => [reviewer];
}

final class ApplyOverviewSubmit extends ApplyOverviewEvent {
  const ApplyOverviewSubmit();

  @override
  List<Object> get props => [];
}

final class ApplyOverviewDeleteEvaluator extends ApplyOverviewEvent {
  const ApplyOverviewDeleteEvaluator();

  @override
  List<Object> get props => [];
}
