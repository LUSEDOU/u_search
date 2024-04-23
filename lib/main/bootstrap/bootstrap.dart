import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:u_search_flutter/main/bootstrap/app_observer.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

typedef AppBuilder = Future<Widget> Function(
  SharedPreferences sharedPreferences,
);

Future<void> bootstrap(AppBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  final appBlocObserver = AppBlocObserver();
  Bloc.observer = appBlocObserver;

  final sharedPreferences = await SharedPreferences.getInstance();

  FlutterError.onError = (details) {
    LoggerManager().e(
      'FlutterError',
      error: details.exception,
      stackTrace: details.stack,
    );
  };

  if (kIsWeb) {
    usePathUrlStrategy();
  }

  runApp(
    await builder(
      sharedPreferences,
    ),
  );
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
