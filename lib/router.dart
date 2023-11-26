import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/login/login.dart';
import 'package:u_search_flutter/register/register.dart';
import 'package:u_search_flutter/review/review.dart';

GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  // redirect: (context, state) async {
  //   Future.delayed(const Duration(milliseconds: 1000));
  //   final appState = context.read<AppBloc>().state;
  //   final logger = LoggerManager().logger;
  //   if (appState.isUnknown && state.path != null) {
  //     logger.i('Path ${state.path} Redirect / AccountType: ${appState.accountType}');
  //     return '/';
  //   } else if (appState.isUnauthenticated)  {
  //     logger.i('Path ${state.path} Redirect /login Status: ${appState.status}');
  //     return '/login';
  //   }
  //   logger.i('Path ${state.path} Redirect null');
  //   return null;
  // },
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (context, state) => const AccountTypePage(),
      // pageBuilder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/applies',
      builder: (context, state) => const ReviewPage2(),
      routes: [
        GoRoute(
          path: 'applies/:id',
          builder: (context, state) => const ReviewPage2(),
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
