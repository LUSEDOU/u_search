import 'package:application_repository/application_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_api/api.dart';
import 'package:u_search_flutter/app/app.dart';

import 'package:u_search_flutter/router/app_router.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({
    required UserRepository userRepository,
    required ApplicationRepository applicationRepository,
    required User user,
    super.key,
  })  : _userRepository = userRepository,
        _applicationRepository = applicationRepository,
        _user = user;

  final UserRepository _userRepository;
  final ApplicationRepository _applicationRepository;
  final User _user;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _applicationRepository),
      ],
      child: BlocProvider(
        create: (context) {
          final userRepository = context.read<UserRepository>();
          return AppBloc(
            userRepository: userRepository,
            user: _user,
          );
        },
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
