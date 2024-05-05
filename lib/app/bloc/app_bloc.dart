import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:u_search_api/api.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';
import 'package:user_repository/user_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> with ChangeNotifier {
  AppBloc({
    required UserRepository userRepository,
    required this.user,
  })  : _userRepository = userRepository,
        super(
          user.isAnonymous
              ? const AppState.unauthenticated()
              : const AppState.authenticated(),
        ) {
    on<_AppUserChanged>(_onUserChanged);
    _userSubscription = _userRepository.user.listen(_userChanged);
  }

  final UserRepository _userRepository;
  late StreamSubscription<User> _userSubscription;
  User user;

  void _userChanged(User user) {
    LoggerManager().d('User changed: $user');
    this.user = user;
    add(_AppUserChanged(user));
  }

  Future<void> _onUserChanged(
    _AppUserChanged event,
    Emitter<AppState> emit,
  ) async {
    user = event.user;
    emit(
      event.user.isAnonymous
          ? const AppState.unauthenticated()
          : const AppState.authenticated(),
    );
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
