part of 'applies_overview_bloc.dart';

enum AppliesOverviewStatus { initial, loading, success, failure }

class AppliesOverviewState extends Equatable {
  const AppliesOverviewState({
    this.status = AppliesOverviewStatus.initial,
    this.applies = const <Apply>[],
  });

  final AppliesOverviewStatus status;
  final List<Apply> applies;

  AppliesOverviewState copyWith({
    AppliesOverviewStatus? status,
    List<Apply>? applies,
  }) {
    return AppliesOverviewState(
      status: status ?? this.status,
      applies: applies ?? this.applies,
    );
  }

  @override
  List<Object> get props => [status, applies];
}
