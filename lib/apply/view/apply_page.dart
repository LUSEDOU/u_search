import 'package:application_repository/application_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_api/api.dart';
import 'package:u_search_flutter/apply/apply.dart';
import 'package:u_search_flutter/contests/contests.dart';

class ApplyPage extends StatelessWidget {
  const ApplyPage({
    required this.contestId,
    this.contest,
    super.key,
  });

  factory ApplyPage.routeBuilder(_, GoRouterState state) {
    final data = state.extra as ApplyData?;
    final contestId =
        data?.contest.id ?? int.parse(state.pathParameters['contestId']!);

    return ApplyPage(
      contestId: contestId,
      key: const Key('apply'),
    );
  }

  final int contestId;
  final Contest? contest;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final applicationRepository = context.read<ApplicationRepository>();
        final bloc = ApplyBloc(
          contest: contest,
          applicationRepository: applicationRepository,
        );

        if (contest == null) {
          bloc.add(ApplyFetchContest(contestId));
        }

        return bloc;
      },
      child: const ApplyView(),
    );
  }
}

class ApplyData extends ContestData {
  const ApplyData({
    required super.contest,
  });
}
