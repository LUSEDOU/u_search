import 'package:application_repository/application_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_api/client.dart';

import '../apply_review.dart';

class ApplyReviewPage extends StatelessWidget {
  const ApplyReviewPage({
    required this.applyId,
    this.review,
    super.key,
  });

  factory ApplyReviewPage.routeBuilder(_, GoRouterState state) {
    final data = state.extra as ApplyReviewData?;
    final applyId = int.parse(state.pathParameters['applyId']!);

    return ApplyReviewPage(
      applyId: applyId,
      review: data?.review,
    );
  }

  final int applyId;
  final Review? review;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final applicationRepository = context.read<ApplicationRepository>();

        final bloc = ApplyReviewBloc(
          review: review ?? Review.empty,
          applyId: applyId,
          applicationRepository: applicationRepository,
        );

        if (review == null) {
          bloc.add(const ApplyReviewRequested());
        }
        return bloc;
      },
      child: const ApplyReviewView(),
    );
  }
}

class ApplyReviewData {
  const ApplyReviewData({
    required this.review,
  });

  final Review review;
}
