import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:u_search_flutter/main/bootstrap/app_observer.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

typedef AppBuilder = Future<Widget> Function();

Future<void> bootstrap(AppBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final appBlocObserver = AppBlocObserver();
  Bloc.observer = appBlocObserver;

  FlutterError.onError = (details) {
    LoggerManager().e(
      'FlutterError',
      error: details.exception,
      stackTrace: details.stack,
    );
  };

  runApp(await builder());
}

// void bootstrap({
//   required AuthClient authClient,
//   required CacheClient cacheClient,
//   required ApiClient apiClient,
//   required DataCacheKeys dataKeys,
//   required AuthCacheKeys authKeys,
// }) {
  // final logger = LoggerManager().logger;
  // FlutterError.onError = (details) {
  //   logger
  //     ..e(details.exceptionAsString())
  //     ..e(details.stack);
  // };
  //
  // final authenticationRepository = AuthenticationRepository(
  //   authClient: authClient,
  //   cacheClient: cacheClient,
  //   keys: authKeys,
  // );
  //
  // final dataRepository = DataRepository(
  //   client: apiClient,
  //   cache: cacheClient,
  //   cacheKeys: dataKeys,
  // );
  //
  // runZonedGuarded(() {
  //   WidgetsFlutterBinding.ensureInitialized();
  //
  //   runApp(
  //     App(
  //       authenticationRepository: authenticationRepository,
  //       dataRepository: dataRepository,
  //     ),
  //   );
  // }, (error, stackTrace) {
  //   logger
  //     ..e(error.toString())
  //     ..e(stackTrace.toString());
  // });
// }
