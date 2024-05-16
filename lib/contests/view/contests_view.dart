import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
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
    final ttheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Concursos disponibles',
          style: ttheme.headlineLarge,
        ),
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
                    leading: const Icon(Icons.star),
                    title: Text(
                      contest.name,
                      style: ttheme.headlineSmall,
                    ),
                    subtitle: Text(
                      contest.description,
                      style: ttheme.bodyLarge,
                    ),
                    trailing: SizedBox(
                      width: 150,
                      child: AppButton.darkAqua(
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Aplica'),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                        onPressed: () =>
                            context.go('/contests/${contest.id}/apply'),
                      ),
                    ),
                    onTap: () => context.go(
                      redirectToApply
                          ? '/contests/${contest.id}/apply'
                          : '/contests/${contest.id}',
                    ),
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
