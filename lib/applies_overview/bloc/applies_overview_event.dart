part of 'applies_overview_bloc.dart';

sealed class AppliesOverviewEvent extends Equatable {
  const AppliesOverviewEvent();

  @override
  List<Object> get props => [];
}

final class AppliesOverviewSubscriptionRequested extends AppliesOverviewEvent {
  const AppliesOverviewSubscriptionRequested();
}

final class AppliesOverviewFetchRequested extends AppliesOverviewEvent {
  const AppliesOverviewFetchRequested({
    required this.user,
  });

  final User user;

  @override
  List<Object> get props => [user];
}
