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
  const ApplyUploadResearch({
    required this.file,
    required this.researcher,
  });

  final File file;
  final Researcher researcher;

  @override
  List<Object> get props => [file, researcher];
}

final class ApplySubmitApplication extends ApplyEvent {
  const ApplySubmitApplication();
}
