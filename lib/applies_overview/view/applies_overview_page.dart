import 'package:application_repository/application_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:u_search_flutter/applies_overview/applies_overview.dart';
import 'package:user_repository/user_repository.dart';

class AppliesOverviewPage extends StatelessWidget {
  const AppliesOverviewPage({super.key});

  factory AppliesOverviewPage.routeBuilder(_) {
    return const AppliesOverviewPage(
      key: Key('appliesOverview'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final userRepository = context.read<UserRepository>();
        final applicationRepository = context.read<ApplicationRepository>();
        return AppliesOverviewBloc(
          userRepository: userRepository,
          applicationRepository: applicationRepository,
        )..add(const AppliesOverviewSubscriptionRequested());
      },
      child: const AppliesOverviewView(),
    );
  }
}
