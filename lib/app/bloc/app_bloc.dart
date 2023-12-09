import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> with ChangeNotifier {
  AppBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState(
                  status: AppStatus.authenticated,
                  user: authenticationRepository.currentUser,
                )
              : const AppState(),
        ) {
    LoggerManager().logger.i(authenticationRepository.currentUser);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<_AppUserChanged>(_onUserChanged);
    on<AppUserTypeChanged>(_onUserTypeChanged);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(_AppUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(
    _AppUserChanged event,
    Emitter<AppState> emit,
  ) {
    emit(
      event.user.isNotEmpty
          ? state.copyWith(
              status: AppStatus.authenticated,
              user: event.user,
            )
          : const AppState(),
    );
    notifyListeners();
  }

  void _onUserTypeChanged(
    AppUserTypeChanged event,
    Emitter<AppState> emit,
  ) {
    emit(
      state.copyWith(
        type: event.type,
      ),
    );
    notifyListeners();
  }

  void _onLogoutRequested(
    AppLogoutRequested event,
    Emitter<AppState> emit,
  ) {
    emit(
      state.copyWith(type: UserType.unknown),
    );
    _authenticationRepository.logOut();
    notifyListeners();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
