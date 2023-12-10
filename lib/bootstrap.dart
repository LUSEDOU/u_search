import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:u_search_flutter/app/app.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

void bootstrap({
  required AuthClient authClient,
  required CacheClient cacheClient,
  required ApiClient apiClient,
  required String userCacheKey,
}) {
  final logger = LoggerManager().logger;
  FlutterError.onError = (details) {
    logger.e(details.exceptionAsString());
    logger.e(details.stack);
  };

  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository(
    authClient: authClient,
    cacheClient: cacheClient,
    userCacheKey: userCacheKey,
  );

  final dataRepository = DataRepository(apiClient);

  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();

    runApp(
      App(
        authenticationRepository: authenticationRepository,
        dataRepository: dataRepository,
      ),
    );
  }, (error, stackTrace) {
    logger.e(error.toString());
    logger.e(stackTrace.toString());
  });
}
