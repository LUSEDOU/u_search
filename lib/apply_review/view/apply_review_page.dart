import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_api/client.dart';

import '../apply_review.dart';

class ApplyReviewPage extends StatelessWidget {
  const ApplyReviewPage({
    required this.applyId,
    this.apply,
    this.review,
    super.key,
  });

  factory ApplyReviewPage.routeBuilder(_, GoRouterState state) {
    final data = state.extra as ApplyReviewData?;
    final apply = data?.apply;

    final applyId = int.parse(state.pathParameters['applyId']!);

    return ApplyReviewPage(
      applyId: applyId,
      apply: apply,
      review: apply?.review,
    );
  }

  final Apply? apply;
  final int applyId;
  final Review? review;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApplyReviewBloc(
        dataRepository: context.read<DataRepository>(),
        apply: _apply,
      ),
      child: const ApplyReviewView(),
    );
  }
}

class ApplyReviewData {
  const ApplyReviewData({
    required this.apply,
    required this.review,
  });

  final Apply apply;
  final Review review;
}
