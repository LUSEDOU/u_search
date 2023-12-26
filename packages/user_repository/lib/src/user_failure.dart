part of 'user_repository.dart';

/// {@template user_failure}
/// A base failure for the [UserRepository] failures.
/// {@endtemplate}
abstract class UserFailure with EquatableMixin implements Exception {
  /// {@macro user_failure}
  const UserFailure(this.error);

  /// The error that was caught.
  final Object error;

  @override
  List<Object> get props => [error];
}

/// {@template fetch_app_opened_count_failure}
/// Thrown when fetching app opened count fails.
/// {@endtemplate}
class FetchAppOpenedCountFailure extends UserFailure {
  /// {@macro fetch_app_opened_count_failure}
  const FetchAppOpenedCountFailure(super.error);
}

/// {@template increment_app_opened_count_failure}
/// Thrown when incrementing app opened count fails.
/// {@endtemplate}
class IncrementAppOpenedCountFailure extends UserFailure {
  /// {@macro increment_app_opened_count_failure}
  const IncrementAppOpenedCountFailure(super.error);
}

/// {@template fetch_current_role_failure}
/// Thrown when fetching current role fails.
/// {@endtemplate}
class FetchCurrentRoleFailure extends UserFailure {
  /// {@macro fetch_current_role_failure}
  const FetchCurrentRoleFailure(super.error);
}
