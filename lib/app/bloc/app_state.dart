part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.unauthenticated,
    this.role = Role.empty,
    this.user = User.empty,
  });

  final AppStatus status;
  final Role role;
  final User user;

  AppState copyWith({
    AppStatus? status,
    Role? role,
    User? user,
  }) {
    return AppState(
      status: status ?? this.status,
      role: role ?? this.role,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [status, role, user];
}

extension AppStateX on AppState {
  bool get isAuthenticated => status == AppStatus.authenticated;
  bool get isUnauthenticated => status == AppStatus.unauthenticated;

  bool get isResearcher => role.isResearcher;
  bool get isReviewer => role.isReviewer;
  bool get isUnknown => role.isUnknown;
  bool get isAdmin => role.isAdmin;
}
