part of 'application_repository.dart';

/// {@template application_failure}
/// A base failure for the application repository failures.
/// {@endtemplate}
abstract class ApplicationFailure with EquatableMixin implements Exception {
  /// {@macro application_failure}
  const ApplicationFailure(this.error);

  /// The error which was caught.
  final Object error;

  @override
  List<Object> get props => [error];
}

/// {@template application_fetch_failure}
/// A failure when fetching applications.
/// {@endtemplate}
class ApplicationFetchFailure extends ApplicationFailure {
  /// {@macro application_fetch_failure}
  const ApplicationFetchFailure(super.error);
}

/// {@template application_send_failure}
/// A failure when sending an application.
/// {@endtemplate}
class ApplicationSendApplyFailure extends ApplicationFailure {
  /// {@macro application_send_failure}
  const ApplicationSendApplyFailure(super.error);
}

/// {@template application_review_failure}
/// A failure when reviewing an application.
/// {@endtemplate}
class ApplicationReviewFailure extends ApplicationFailure {
  /// {@macro application_review_failure}
  const ApplicationReviewFailure(super.error);
}

/// {@template application_select_reviewer_failure}
/// A failure when selecting a reviewer.
/// {@endtemplate}
class ApplicationSelectReviewerFailure extends ApplicationFailure {
  /// {@macro application_select_reviewer_failure}
  const ApplicationSelectReviewerFailure(super.error);
}
