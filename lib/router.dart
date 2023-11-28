import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/app/app.dart';
import 'package:u_search_flutter/applies_overview/view/apply_overview_page.dart';
import 'package:u_search_flutter/applies_overview/view/view.dart';
import 'package:u_search_flutter/login/login.dart';
import 'package:u_search_flutter/review/review.dart';
import 'package:u_search_flutter/sign_up/sign_up.dart';
import 'package:u_search_flutter/user_type/user_type.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

GoRouter router(AppBloc bloc) => GoRouter(
      initialLocation: '/applies',
      debugLogDiagnostics: true,
      refreshListenable: bloc,
      redirect: (context, state) async {
        final logger = LoggerManager().logger;

        logger.i('Full path: ${state.fullPath}');
        final bloc = context.read<AppBloc>();
        if (bloc.state.isUnknown) {
          logger.i('Redirecting to /');
          return '/';
        }
        if (bloc.state.isUnauthenticated &&
            !(state.fullPath?.startsWith('/auth') ?? false)) {
          logger.i('Redirecting to /auth');
          return '/auth/login';
        }

        logger.i('No redirect from ${state.fullPath}');
        return null;
      },
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          builder: (context, state) => const UserTypePage(),
          redirect: (context, state) async {
            final logger = LoggerManager().logger;
            logger.i('Redirecting from ${state.path}');
            if (!context.read<AppBloc>().state.isUnknown) {
              logger.i('Redirecting to /applies');
              return '/applies';
            }
            return null;
          },
        ),
        GoRoute(
          path: '/auth',
          redirect: (context, state) async {
            final logger = LoggerManager().logger;
            logger.i('Redirecting from ${state.path}');
            if (context.read<AppBloc>().state.isAuthenticated) {
              logger.i('Redirecting to /applies');
              return '/applies';
            }
            return null;
          },
          builder: (context, state) => const LoginPage(),
          routes: [
            GoRoute(
              path: 'login',
              builder: (context, state) => const LoginPage(),
            ),
            GoRoute(
              path: 'sign_up',
              builder: (context, state) => const SignUpPage(),
            ),
          ],
        ),
        GoRoute(
          path: '/applies',
          builder: (context, state) => const AppliesOverviewPage(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) => const ApplyOverviewPage(),
              routes: [
                GoRoute(
                  path: 'review',
                  builder: (context, state) => const ReviewPage2(),
                ),
              ],
            ),
          ],
        ),
        // GoRoute(
        //   path: '/reviews',
        //   builder: (context, state) => const ReviewPage2(),
        // ),
      ],
    );

class AppStateNotifier extends ChangeNotifier {
  late final StreamSubscription<AppState> _subscription;

  AppStateNotifier(AppBloc bloc) {
    _subscription = bloc.stream.listen((event) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
