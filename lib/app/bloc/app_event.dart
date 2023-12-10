part of 'app_bloc.dart';

sealed class AppEvent extends Equatable{
  const AppEvent();
}

final class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();

  @override
  List<Object> get props => [];
}

final class _AppUserChanged extends AppEvent {
  const _AppUserChanged(this.user);
  final User user;

  @override
  List<Object> get props => [user];
}

final class AppRoleChanged extends AppEvent {
  const AppRoleChanged(this.role);
  final Role role;

  @override
  List<Object> get props => [role];
}
