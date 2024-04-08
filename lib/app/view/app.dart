import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:u_search_flutter/router/app_router.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({
    required UserRepository userRepository,
    super.key,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _userRepository),
      ],
      // child: BlocProvider(
      //   create: (_) => AppBloc(),
      child: const AppView(),
      // ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
