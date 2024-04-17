// import 'package:data_repository/data_repository.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/applies_overview/applies_overview.dart';
import 'package:u_search_flutter/apply/apply.dart';
import 'package:u_search_flutter/apply_overview/apply_overview.dart';
import 'package:u_search_flutter/auth/views/auth_page.dart';
// import 'package:u_search_flutter/app/app.dart';
// import 'package:u_search_flutter/applies_overview/view/view.dart';
// import 'package:u_search_flutter/apply/apply.dart';
// import 'package:u_search_flutter/apply_overview/apply_overview.dart';
// import 'package:u_search_flutter/apply_review/apply_review.dart';
// import 'package:u_search_flutter/login/login.dart';
// import 'package:u_search_flutter/role_selector/role_selector.dart';
// import 'package:u_search_flutter/sign_up/sign_up.dart';
// import 'package:u_search_flutter/utils/logger_manager.dart';
import 'package:u_search_flutter/welcome/views/welcome_page.dart';

GoRouter router = GoRouter(
  initialLocation: '/auth',
  debugLogDiagnostics: true,
  // redirect: (context, state) async {
  //   final logger = LoggerManager().logger;
  //   final bloc = context.read<AppBloc>();
  //   if (bloc.state.isUnknown) {
  //     logger.i('From ${state.fullPath} To /');
  //     return '/';
  //   }
  //   if (bloc.state.isUnauthenticated &&
  //       !(state.fullPath?.startsWith('/auth') ?? false)) {
  //     logger.i('From ${state.fullPath} To /auth/login');
  //     return '/auth/login';
  //   }
  //   // logger.i('No redirect from ${state.fullPath}');
  //   return null;
  // },
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: WelcomePage.routeBuilder,
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthPage(token: 'token'),
    ),
    GoRoute(
      path: '/login',
      builder: AuthPage.routeBuilder,
    ),
    // GoRoute(
    //   path: '/applies/new',
    //   builder: (context, state) => const ApplyPage(),
    // ),
    GoRoute(
      path: '/applies',
      builder: AppliesOverviewPage.routeBuilder,
      routes: [
        GoRoute(
          path: ':applyId',
          builder: ApplyOverviewPage.routeBuilder,
          redirect: (context, state) {
            final id = int.tryParse(state.pathParameters['applyId']!);
            return id == null ? '/applies' : null;
          },
        ),
      ],
    ),
    GoRoute(
      path: '/contests',
      routes: [
        GoRoute(
          path: ':contestId',
          routes: [
            GoRoute(
              path: 'apply',
              builder: ApplyPage.routeBuilder,
            ),
          ],
        ),
      ],
    ),
    //   routes: [
    //     GoRoute(
    //       path: ':applyId',
    //       redirect: (context, state) async {
    //         final logger = LoggerManager().logger;
    //         final id = int.tryParse(state.pathParameters['applyId'].toString());
    //         if (id == null) {
    //           logger.i('From ${state.fullPath} To /applies/new');
    //           return '/applies/new';
    //         }
    //         logger.i('To ${state.fullPath}');
    //         return null;
    //       },
    //       builder: (context, state) => ApplyOverviewPage(
    //         id: int.parse(state.pathParameters['applyId'].toString()),
    //         apply: state.extra is Apply ? state.extra! as Apply : null,
    //       ),
    //       routes: [
    //         GoRoute(
    //           path: 'review',
    //           builder: (context, state) => ApplyReviewPage(
    //             apply: state.extra! as Apply,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ],
    // ),
  ],
);
