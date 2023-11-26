part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

enum AppMode { user, evaluator, admin, unknown }

class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.unauthenticated,
    this.mode = AppMode.unknown,
    this.user = User.empty,
  });

  final AppStatus status;
  final AppMode mode;
  final User user;

  AppState copyWith({
    AppStatus? status,
    AppMode? mode,
    User? user,
  }) {
    return AppState(
      status: status ?? this.status,
      mode: mode ?? this.mode,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [status, mode, user];
}
