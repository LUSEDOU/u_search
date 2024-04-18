import 'package:application_repository/application_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:u_search_flutter/contests/contests.dart';

class ContestsPage extends StatelessWidget {
  const ContestsPage({
    super.key,
    this.redirectToApply,
  });

  factory ContestsPage.routeBuilder(_, __) {
    return const ContestsPage(
      key: Key('contests'),
    );
  }

  final bool? redirectToApply;

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

class ContestsView extends StatelessWidget {
  const ContestsView({
    super.key,
    this.redirectToApply,
  });

  final bool? redirectToApply;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContestsBloc, ContestsState>(
      builder: (context, state) {
        final status = state.status;
        if (status == ContestsStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (status == ContestsStatus.success) {
          final contests = state.contests;
          return ListView.builder(
            itemCount: contests.length,
            itemBuilder: (context, index) {
              final contest = contests[index];
              return ListTile(
                title: Text(contest.name),
                subtitle: Text(contest.description),
                onTap: () {
                  context.go(
                    (redirectToApply ?? false)
                        ? '/contests/${contest.id}/apply'
                        : '/contests/${contest.id}',
                  );
                },
              );
            },
          );
        } else {
          return const Center(
            child: Text('Failed to load contests'),
          );
        }
      },
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
