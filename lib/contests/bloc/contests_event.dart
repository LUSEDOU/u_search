part of 'contests_bloc.dart';

sealed class ContestsEvent extends Equatable {
  const ContestsEvent();

  @override
  List<Object> get props => [];
}

final class ContestsRequested extends ContestsEvent {
  const ContestsRequested();
}
