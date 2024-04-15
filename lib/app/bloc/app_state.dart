part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

class AppState extends Equatable {
  const AppState._({
    this.status = AppStatus.unauthenticated,
  });
  const AppState.authenticated() : this._(status: AppStatus.authenticated);
  const AppState.unauthenticated() : this._();

  final AppStatus status;

  AppState copyWith({
    AppStatus? status,
  }) {
    return AppState._(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}

extension AppStateX on AppState {
  bool get isAuthenticated => status == AppStatus.authenticated;
  bool get isUnauthenticated => status == AppStatus.unauthenticated;
}
