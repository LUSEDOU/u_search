part of 'applies_bloc.dart';

sealed class AppliesEvent extends Equatable {
  const AppliesEvent();

  @override
  List<Object> get props => [];
}

final class AppliesSubscriptionRequested extends AppliesEvent {
  const AppliesSubscriptionRequested();
}
