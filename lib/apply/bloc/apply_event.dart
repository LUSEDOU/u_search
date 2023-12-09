part of 'apply_bloc.dart';

sealed class ApplyEvent extends Equatable {
  const ApplyEvent();

  @override
  List<Object> get props => [];
}

final class ApplyFetchContests extends ApplyEvent {
  const ApplyFetchContests();
}

final class ApplySelectContest extends ApplyEvent {
  const ApplySelectContest(this.contest);

  final Contest contest;

  @override
  List<Object> get props => [contest];
}

final class ApplyUploadResearch extends ApplyEvent {
  const ApplyUploadResearch(this.file);

  final File file;

  @override
  List<Object> get props => [file];
}

final class ApplySubmitApplication extends ApplyEvent {
  const ApplySubmitApplication();
}
