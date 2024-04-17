part of 'contests_bloc.dart';

enum ContestsStatus { initial, loading, success, failure }

class ContestsState extends Equatable {
  const ContestsState({
    this.status = ContestsStatus.initial,
    this.contests = const [],
  });

  final List<Contest> contests;
  final ContestsStatus status;

  ContestsState copyWith({
    ContestsStatus? status,
    List<Contest>? contests,
  }) {
    return ContestsState(
      status: status ?? this.status,
      contests: contests ?? this.contests,
    );
  }

  @override
  List<Object> get props => [status, contests];
}
