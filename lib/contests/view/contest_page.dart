import 'package:application_repository/application_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_api/client.dart';

import 'package:u_search_flutter/contests/contests.dart';

class ContestPage extends StatelessWidget {
  const ContestPage({
    required this.id,
    this.contest,
    super.key,
  });

  factory ContestPage.routeBuilder(_, GoRouterState state) {
    final data = state.extra as ContestData?;
    final id = int.parse(state.pathParameters['contestId']!);

    return ContestPage(
      id: id,
      key: const Key('contest'),
      contest: data?.contest,
    );
  }

  final Contest? contest;
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) {
        final applicationRepository = ctx.read<ApplicationRepository>();
        final bloc = ContestBloc(
          applicationRepository: applicationRepository,
          contest: contest,
        );

        if (contest == null) {
          bloc.add(ContestRequested(id));
        }

        return bloc;
      },
      child: const ContestView(),
    );
  }
}

class ContestData extends ContestsData {
  const ContestData({
    required this.contest,
  }) : super(redirectToApply: false);

  final Contest contest;

  @override
  List<Object> get props => [contest];
}
