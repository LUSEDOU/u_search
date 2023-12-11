import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache_client/cache_client.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:u_search_flutter/app/app.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

void bootstrap({
  required AuthClient authClient,
  required CacheClient cacheClient,
  required ApiClient apiClient,
  required DataCacheKeys dataKeys,
  required AuthCacheKeys authKeys,
}) {
  final logger = LoggerManager().logger;
  FlutterError.onError = (details) {
    logger
      ..e(details.exceptionAsString())
      ..e(details.stack);
  };

  final authenticationRepository = AuthenticationRepository(
    authClient: authClient,
    cacheClient: cacheClient,
    keys: authKeys,
  );

  final dataRepository = DataRepository(
    client: apiClient,
    cache: cacheClient,
    cacheKeys: dataKeys,
  );

  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();

    runApp(
      App(
        authenticationRepository: authenticationRepository,
        dataRepository: dataRepository,
      ),
    );
  }, (error, stackTrace) {
    logger
      ..e(error.toString())
      ..e(stackTrace.toString());
  });
}
