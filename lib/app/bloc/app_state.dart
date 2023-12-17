part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

class AppState extends Equatable {
  const AppState._({
    this.status = AppStatus.unauthenticated,
    this.role = const Unknown(),
  });

  const AppState.unknown() : this._();

  const AppState.authenticated({
    required this.role,
  }) : status = AppStatus.authenticated;

  const AppState.unauthenticated({
    required this.role,
  }) : status = AppStatus.unauthenticated;

  final AppStatus status;
  final Role role;

  @override
  List<Object> get props => [status, role];
}

extension AppStateX on AppState {
  bool get isAuthenticated => status == AppStatus.authenticated;
  bool get isUnauthenticated => status == AppStatus.unauthenticated;

  bool get isResearcher => role.isResearcher;
  bool get isReviewer => role.isReviewer;
  bool get isUnknown => role.isUnknown;
  bool get isAdmin => role.isAdmin;
}
