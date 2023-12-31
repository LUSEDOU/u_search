part of 'applies_overview_bloc.dart';

sealed class AppliesOverviewEvent extends Equatable {
  const AppliesOverviewEvent();

  @override
  List<Object> get props => [];
}

final class AppliesOverviewSubscriptionRequested extends AppliesOverviewEvent {
  const AppliesOverviewSubscriptionRequested(this.role);

  final Role role;

  @override
  List<Object> get props => [role];
}
