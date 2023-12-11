import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:authentication_repository/authentication_repository.dart'
    as auth;
import 'package:data_repository/data_repository.dart';

import 'package:u_search_flutter/utils/logger_manager.dart';
import 'package:u_search_flutter/utils/models_extensions.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> with ChangeNotifier {
  AppBloc({
    required auth.AuthenticationRepository authenticationRepository,
    required DataRepository dataRepository,
  })  : _authenticationRepository = authenticationRepository,
        _dataRepository = dataRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState(
                  status: AppStatus.authenticated,
                  user: authenticationRepository.currentUser.toModel(),
                  role: dataRepository.currentRole,
                )
              : AppState(
                  role: dataRepository.currentRole,
                ),
        ) {
    LoggerManager().logger.i(authenticationRepository.currentUser);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<_AppUserChanged>(_onUserChanged);
    on<AppRoleChanged>(_onRoleChanged);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(_AppUserChanged(user.toModel())),
    );
    _roleSubscription = _dataRepository.role.listen(
      (role) => add(AppRoleChanged(role)),
    );
  }

  final auth.AuthenticationRepository _authenticationRepository;
  final DataRepository _dataRepository;
  late final StreamSubscription<auth.User> _userSubscription;
  late final StreamSubscription<Role> _roleSubscription;

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
    // notifyListeners();
  }

  void _onRoleChanged(
    AppRoleChanged event,
    Emitter<AppState> emit,
  ) {
    emit(
      state.copyWith(
        role: event.role,
      ),
    );
    // notifyListeners();
  }

  void _onLogoutRequested(
    AppLogoutRequested event,
    Emitter<AppState> emit,
  ) {
    _dataRepository.logOut();
    _authenticationRepository.logOut();
    notifyListeners();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _roleSubscription.cancel();
    return super.close();
  }
}

