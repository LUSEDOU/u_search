part of 'apply_overview_bloc.dart';

sealed class ApplyOverviewEvent extends Equatable {
  const ApplyOverviewEvent();

  @override
  List<Object?> get props => [];
}

final class ApplyOverviewRequested extends ApplyOverviewEvent {
  const ApplyOverviewRequested({required this.id});
  final int id;

  @override
  List<Object> get props => [id];
}

final class ApplyOverviewReviewerChanged extends ApplyOverviewEvent {
  const ApplyOverviewReviewerChanged(this.reviewer);
  final User? reviewer;

  @override
  List<Object?> get props => [reviewer];
}

final class ApplyOverviewSubmit extends ApplyOverviewEvent {
  const ApplyOverviewSubmit();
}

final class ApplyOverviewDownloadRequested extends ApplyOverviewEvent {
  const ApplyOverviewDownloadRequested();
}
