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
