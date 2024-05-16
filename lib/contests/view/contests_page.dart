import 'package:application_repository/application_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:u_search_flutter/contests/contests.dart';

class ContestsPage extends StatelessWidget {
  const ContestsPage({
    required this.redirectToApply,
    super.key,
  });

  factory ContestsPage.routeBuilder(_, GoRouterState state) {
    final data = state.extra as ContestsData?;

    return ContestsPage(
      key: const Key('contests'),
      redirectToApply: data?.redirectToApply ?? false,
    );
  }

  final bool redirectToApply;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final applicationRepository = context.read<ApplicationRepository>();
        return ContestsBloc(
          applicationRepository: applicationRepository,
        )..add(const ContestsRequested());
      },
      child: ContestsView(
        redirectToApply: redirectToApply,
      ),
    );
  }
}

class ContestsData extends Equatable {
  const ContestsData({
    required this.redirectToApply,
  });
  final bool redirectToApply;

  @override
  List<Object> get props => [redirectToApply];
}
