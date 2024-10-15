part of 'contest_edit_bloc.dart';

sealed class ContestEditEvent extends Equatable {
  const ContestEditEvent();
}

final class ContestEditRequested extends ContestEditEvent {
  const ContestEditRequested();

  @override
  List<Object> get props => [];
}
