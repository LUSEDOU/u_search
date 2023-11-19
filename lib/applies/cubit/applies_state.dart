part of 'applies_cubit.dart';

enum AppliesStatus { initial, loading, success, failure }

class AppliesState extends Equatable {
  const AppliesState({
    this.status = AppliesStatus.initial,
    this.applies = const <Apply>[],
    this.hasReachedMax = false,
  });

  final AppliesStatus status;
  final List<Apply> applies;
  final bool hasReachedMax;

  AppliesState copyWith({
    AppliesStatus? status,
    List<Apply>? applies,
    bool? hasReachedMax,
  }) {
    return AppliesState(
      status: status ?? this.status,
      applies: applies ?? this.applies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, applies, hasReachedMax];
}
