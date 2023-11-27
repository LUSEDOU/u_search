import 'dart:async';
import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:u_search_flutter/app/app.dart';

void bootstrap({
  required AuthClient authClient,
  required CacheClient cacheClient,
  required ApiClient apiClient,
  required String userCacheKey,
}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository(
    authClient: authClient,
    cacheClient: cacheClient,
    userCacheKey: userCacheKey,
  );

  final dataRepository = DataRepository(apiClient);

  runZonedGuarded(
    () => runApp(
      App(
        authenticationRepository: authenticationRepository,
        dataRepository: dataRepository,
      ),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
