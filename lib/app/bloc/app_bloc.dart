import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:u_search_flutter/utils/models_extensions.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> with ChangeNotifier {
  AppBloc({
    required DataRepository dataRepository,
  })  : _dataRepository = dataRepository,
        super(
          dataRepository.currentRole.isCreated
              ? AppState.authenticated(role: dataRepository.currentRole)
              : AppState.unauthenticated(role: dataRepository.currentRole),
        ) {
    on<_AppLogoutRequested>(_onLogoutRequested);
    on<_AppRoleChanged>(_onRoleChanged);
    _roleSubscription = _dataRepository.role.listen(
      (role) => add(_AppRoleChanged(role)),
    );
  }

  final DataRepository _dataRepository;
  late final StreamSubscription<Role> _roleSubscription;

  void _onRoleChanged(
    _AppRoleChanged event,
    Emitter<AppState> emit,
  ) {
    if (event.role.isCreated) {
      emit(
        AppState.authenticated(role: event.role),
      );
    } else {
      emit(
        AppState.unauthenticated(role: event.role),
      );
    }
  }

  void _onLogoutRequested(
    _AppLogoutRequested event,
    Emitter<AppState> emit,
  ) {
    _dataRepository.logOut();
    notifyListeners();
  }

  @override
  Future<void> close() {
    _roleSubscription.cancel();
    return super.close();
  }
}
