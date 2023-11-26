import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

class AppBlocObserver extends BlocObserver {
  final _logger = LoggerManager().logger;

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _logger.i('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _logger.e('${bloc.runtimeType} $error $stackTrace');
  }
}
