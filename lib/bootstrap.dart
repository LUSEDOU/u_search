import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';

void bootstrap() {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // Bloc.observer = const AppBlocObserver();

  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  runZonedGuarded(
    () => runApp(
      App(authenticationRepository: authenticationRepository),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
