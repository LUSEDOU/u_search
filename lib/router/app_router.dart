import 'package:data_repository/data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/app/app.dart';
import 'package:u_search_flutter/applies_overview/view/view.dart';
import 'package:u_search_flutter/apply/apply.dart';
import 'package:u_search_flutter/apply_overview/apply_overview.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';
import 'package:u_search_flutter/login/login.dart';
import 'package:u_search_flutter/role_selector/role_selector.dart';
import 'package:u_search_flutter/sign_up/sign_up.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

GoRouter router = GoRouter(
  initialLocation: '/applies',
  debugLogDiagnostics: true,
  redirect: (context, state) async {
    final logger = LoggerManager().logger;
    final bloc = context.read<AppBloc>();
    if (bloc.state.isUnknown) {
      logger.i('From ${state.fullPath} To /');
      return '/';
    }
    if (bloc.state.isUnauthenticated &&
        !(state.fullPath?.startsWith('/auth') ?? false)) {
      logger.i('From ${state.fullPath} To /auth/login');
      return '/auth/login';
    }
    // logger.i('No redirect from ${state.fullPath}');
    return null;
  },
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (context, state) => const RoleSelectorPage(),
    ),
    GoRoute(
      path: '/auth',
      redirect: (context, state) async {
        final logger = LoggerManager().logger;
        if (context.read<AppBloc>().state.isAuthenticated) {
          logger.i('From ${state.fullPath} To /applies');
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
      path: '/applies/new',
      builder: (context, state) => const ApplyPage(),
    ),
    GoRoute(
      path: '/applies',
      builder: (context, state) => const AppliesOverviewPage(),
      routes: [
        GoRoute(
          path: ':applyId',
          redirect: (context, state) async {
            final logger = LoggerManager().logger;
            final id = int.tryParse(state.pathParameters['applyId'].toString());
            if (id == null) {
              logger.i('From ${state.fullPath} To /applies/new');
              return '/applies/new';
            }
            logger.i('To ${state.fullPath}');
            return null;
          },
          builder: (context, state) => ApplyOverviewPage(
            id: int.parse(state.pathParameters['applyId'].toString()),
            apply: state.extra is Apply ? state.extra! as Apply : null,
          ),
          routes: [
            GoRoute(
              path: 'review',
              builder: (context, state) => ApplyReviewPage(
                apply: state.extra! as Apply,
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
