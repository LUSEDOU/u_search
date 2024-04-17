import 'package:application_repository/application_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_api/api.dart';
import 'package:u_search_flutter/apply/apply.dart';

class ApplyPage extends StatelessWidget {
  const ApplyPage({
    required this.contestId,
    super.key,
  });

  factory ApplyPage.routeBuilder(_, GoRouterState state) {
    final contestId = int.parse(state.pathParameters['contestId']!);

    return ApplyPage(
      contestId: contestId,
      key: const Key('apply'),
    );
  }

  final int contestId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final applicationRepository = context.read<ApplicationRepository>();
        return ApplyBloc(
          contest: contestId,
          applicationRepository: applicationRepository,
        );
      },
      child: const ApplyView(),
    );
  }
}
