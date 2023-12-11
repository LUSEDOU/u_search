import 'package:authentication_repository/authentication_repository.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:u_search_flutter/app/app.dart';
import 'package:u_search_flutter/router.dart';


class App extends StatelessWidget {
  const App({
    required AuthenticationRepository authenticationRepository,
    required DataRepository dataRepository,
    super.key,
  })  : _authenticationRepository = authenticationRepository,
        _dataRepository = dataRepository;

  final AuthenticationRepository _authenticationRepository;
  final DataRepository _dataRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>.value(
          value: _authenticationRepository,
        ),
        RepositoryProvider<DataRepository>.value(
          value: _dataRepository,
        ),
      ],
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
          dataRepository: _dataRepository,
        ),
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router(context.read<AppBloc>()),
    );
  }
}
