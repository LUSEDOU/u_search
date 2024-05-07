part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

class AppState extends Equatable {
  const AppState._({
    required this.user,
    this.status = AppStatus.unauthenticated,
  });
  const AppState.authenticated({required User user})
      : this._(status: AppStatus.authenticated, user: user);
  const AppState.unauthenticated() : this._(user: User.anonymous);

  final AppStatus status;
  final User user;

  AppState copyWith({
    AppStatus? status,
    User? user,
  }) {
    return AppState._(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [status, user];
}

extension AppStateX on AppState {
  bool get isAuthenticated => status == AppStatus.authenticated;
  bool get isUnauthenticated => status == AppStatus.unauthenticated;
}
