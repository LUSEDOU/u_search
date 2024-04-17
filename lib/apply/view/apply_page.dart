import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_api/api.dart';
import 'package:u_search_flutter/apply/apply.dart';

import 'package:user_repository/user_repository.dart';

class ApplyPage extends StatelessWidget {
  const ApplyPage({
    required this.contestId,
    this.contest,
    super.key,
  });

  factory ApplyPage.routeBuilder(_, GoRouterState state) {
    final data = state.extra as ApplyPageData?;
    final contest = data?.contest;

    final contestId =
        contest?.id ?? int.parse(state.pathParameters['contestId']!);

    return ApplyPage(
      contestId: contestId,
      contest: contest,
      key: const Key('apply'),
    );
  }

  final int contestId;
  final Contest? contest;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final userRepository = context.read<UserRepository>();
        final bloc = ApplyBloc(userRepository: userRepository);

        if (contest == null) {
          bloc.add(ApplyRequested(contestId));
        }

        return bloc..add(const ApplyFetchContests());
      },
      child: const ApplyView(),
    );
  }
}

class ApplyPageData extends Equatable {
  const ApplyPageData({
    required this.contest,
  });

  final Contest? contest;

  @override
  List<Object?> get props => [contest];
}
