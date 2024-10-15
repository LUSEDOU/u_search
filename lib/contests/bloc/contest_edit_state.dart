part of 'contest_edit_bloc.dart';

enum ContestEditStatus { initial, validating, loading, success, failure }

class ContestEditState extends Equatable {
  const ContestEditState({
    this.status = ContestEditStatus.initial,
  });

  final ContestEditStatus status;

  ContestEditState copyWith({
    ContestEditStatus? status,
  }) {
    return ContestEditState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}
