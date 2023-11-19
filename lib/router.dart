import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/review/review.dart';

GoRouter router = GoRouter(
  initialLocation: '/reviews',
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (context, state) => const ReviewPage2(),
      // pageBuilder: (context, state) => HomePage(),
      routes: [
        GoRoute(
          path: 'applies',
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
        GoRoute(
          path: 'reviews',
          builder: (context, state) => const ReviewPage2(),
        ),
      ],
    ),
  ],
);
