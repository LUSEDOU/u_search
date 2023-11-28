import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/app/app.dart';

import '../applies_overview.dart';

class AppliesOverviewPage extends StatelessWidget {
  const AppliesOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppliesOverviewBloc(
        dataRepository: context.read<DataRepository>(),
      )..add(const AppliesOverviewSubscriptionRequested()),
      child: const AppliesOverviewView(),
    );
  }
}

class AppliesOverviewView extends StatelessWidget {
  const AppliesOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Applies Overview'),
      ),
      body: BlocConsumer<AppliesOverviewBloc, AppliesOverviewState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == AppliesOverviewStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Applies Failure'),
                ),
              );
          }
        },
        builder: (context, state) {
          if (state.applies.isEmpty) {
            if (state.status == AppliesOverviewStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status != AppliesOverviewStatus.success) {
              return const SizedBox();
            } else {
              return const Center(
                child: Text(
                  'No Applies',
                ),
              );
            }
          }

          return CupertinoScrollbar(
            child: ListView(
              children: [
                const WelcomeText(),
                for (final apply in state.applies)
                  ApplyTile(
                    apply: apply,
                    onTap: () => context.go('${apply.id}'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Text(
          'Hi! ${state.user.email}',
          style: theme.textTheme.titleLarge,
        );
      },
    );
  }
}

class ApplyTile extends StatelessWidget {
  const ApplyTile({
    required this.apply,
    super.key,
    this.onTap,
  });

  final Apply apply;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Apply ${apply.id}'),
      onTap: onTap,
      trailing: apply.review != null
          ? const Icon(Icons.check_circle_outline)
          : const Icon(Icons.pending_outlined),
    );
  }
}
