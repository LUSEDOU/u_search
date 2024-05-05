import 'package:app_ui/app_ui.dart';
import 'package:application_repository/application_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:u_search_flutter/contests/contests.dart';

class ContestsView extends StatelessWidget {
  const ContestsView({
    required this.redirectToApply,
    super.key,
  });

  final bool redirectToApply;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Concursos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxlg),
        child: BlocBuilder<ContestsBloc, ContestsState>(
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
                    leading: const Icon(Icons.dashboard_customize),
                    title: Text(contest.name),
                    subtitle: Text(contest.description),
                    onTap: () {
                      context.go(
                        redirectToApply
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
        ),
      ),
    );
  }
}
