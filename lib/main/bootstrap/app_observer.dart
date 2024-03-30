import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

class AppBlocObserver extends BlocObserver {
  AppBlocObserver();
  //   required AnalyticsRepository analyticsRepository,
  // }) : _analyticsRepository = analyticsRepository;

  // final AnalyticsRepository _analyticsRepository;

  final _logger = LoggerManager();

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    _logger.i('onTransition ${bloc.runtimeType}: $transition');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _logger.e(
      'onError ${bloc.runtimeType}',
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    // final dynamic state = change.nextState;
    // if (state is AnalyticsEventMixin) {
    //   _analyticsRepository.track(state.event);
    // }
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    // if (event is AnalyticsEventMixin) {
    //   _analyticsRepository.track(
    //     event.event,
    //   );
    // }
  }
}
