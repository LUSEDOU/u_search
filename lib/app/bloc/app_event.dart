part of 'app_bloc.dart';

sealed class AppEvent extends Equatable{
  const AppEvent();
}

final class _AppLogoutRequested extends AppEvent {
  const _AppLogoutRequested();

  @override
  List<Object> get props => [];
}

final class _AppUserChanged extends AppEvent {
  const _AppUserChanged(this.user);
  final User user;

  @override
  List<Object> get props => [user];
}

final class _AppRoleTypeChanged extends AppEvent {
  const _AppRoleTypeChanged(this.type);
  final RoleType type;

  @override
  List<Object> get props => [type];
}

final class _AppRoleChanged extends AppEvent {
  const _AppRoleChanged(this.role);
  final Role role;

  @override
  List<Object> get props => [role];
}
