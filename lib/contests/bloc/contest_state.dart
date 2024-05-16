part of 'contest_bloc.dart';

enum ContestStatus { initial, loading, success, failure }

class ContestState extends Equatable {
  const ContestState({
      required this.contest,
    this.status = ContestStatus.initial,
  });

  final Contest contest;
  final ContestStatus status;

  ContestState copyWith({
    ContestStatus? status,
    Contest? contest,
  }) {
    return ContestState(
      status: status ?? this.status,
      contest: contest ?? this.contest,
    );
  }

  @override
  List<Object> get props => [status, contest];
}
