import 'package:flutter/material.dart';

import 'package:u_search_flutter/router/app_router.dart';

class App extends StatelessWidget {
  const App({
    // required AuthenticationRepository authenticationRepository,
    // required DataRepository dataRepository,
    // required UserRepository userRepository,
    super.key,
  });
  // })  : _authenticationRepository = authenticationRepository,
  //       _dataRepository = dataRepository;

  // final AuthenticationRepository _authenticationRepository;
  // final DataRepository _dataRepository;
  // final UserRepository _userRepository;

  @override
  Widget build(BuildContext context) {
    return const AppView();
    // return MultiRepositoryProvider(
    //   providers: const [
        // RepositoryProvider.value(value: _userRepository),
        // RepositoryProvider<AuthenticationRepository>.value(
        //   value: _authenticationRepository,
        // ),
        // RepositoryProvider<DataRepository>.value(
        //   value: _dataRepository,
        // ),
      // ],
      // child: BlocProvider(
      //   create: (_) => AppBloc(
      //     dataRepository: _dataRepository,
      //   ),
      // child: const AppView(),
      // ),
    // );
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
