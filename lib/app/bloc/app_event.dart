part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

final class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}

final class _AppUserChanged extends AppEvent {
  const _AppUserChanged(this.user);
  final User user;
}

final class _AppModeChanged extends AppEvent {
  const _AppModeChanged(this.mode);
  final AppMode mode;
}
