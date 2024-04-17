part of 'apply_bloc.dart';

enum ApplyStatus { initial, loading, success, failure, finished }

class ApplyState extends Equatable {
  const ApplyState({
    this.status = ApplyStatus.initial,
    this.file,
  });

  final ApplyStatus status;
  final File? file;

  ApplyState copyWith({
    ApplyStatus? status,
    File? file,
  }) {
    return ApplyState(
      status: status ?? this.status,
      file: file ?? this.file,
    );
  }

  @override
  List<Object?> get props => [file, status];
}
