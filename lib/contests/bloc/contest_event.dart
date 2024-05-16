part of 'contest_bloc.dart';

sealed class ContestEvent extends Equatable {
  const ContestEvent();

  @override
  List<Object> get props => [];
}

final class ContestRequested extends ContestEvent {
  const ContestRequested(this.id);
  final int id;
  @override
  List<Object> get props => [id];
}
