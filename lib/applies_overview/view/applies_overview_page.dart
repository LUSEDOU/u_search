import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/app/app.dart';

import 'package:u_search_flutter/applies_overview/applies_overview.dart';
import 'package:u_search_flutter/utils/dart_extensions.dart';
import 'package:u_search_flutter/utils/models_extensions.dart';

class AppliesOverviewPage extends StatelessWidget {
  const AppliesOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppliesOverviewBloc(
        dataRepository: context.read<DataRepository>(),
      )..add(
          AppliesOverviewSubscriptionRequested(
            context.read<AppBloc>().state.role,
          ),
        ),
      child: const AppliesOverviewView(),
    );
  }
}

class AppliesOverviewView extends StatelessWidget {
  const AppliesOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final role = context.read<AppBloc>().state.role;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Applies Overview'),
      ),
      floatingActionButton: role.isResearcher
          ? FloatingActionButton(
              onPressed: () => context.go('/applies/new'),
              child: const Icon(Icons.add),
            )
          : null,
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
              return Center(
                child: Text(
                  role.isReviewer
                      ? 'Wait until we assign you an apply'
                      : 'You have no applies',
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
                    onTap: () => context.go(
                      '/applies/${apply.id}',
                      extra: apply,
                    ),
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
          'Hi! ${state.role.user.email}',
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
      title: Row(
        children: [
          Text('Apply ${apply.id} - ${apply.contest.name}'),
          if (apply.reviewer != null)
            BulletText(
              text: 'Reviewer assigned',
              color: Colors.green.withOpacity(0.5),
              textColor: Colors.green.shade900,
            )
          else
            BulletText(
              text: 'Reviewer Pending',
              color: Colors.yellow.withOpacity(0.5),
              textColor: Colors.yellow.shade900,
            ),
          if (apply.review != null)
            BulletText(
              text: 'Reviewed',
              color: Colors.green.withOpacity(0.5),
              textColor: Colors.green.shade900,
            )
          else
            BulletText(
              text: 'Pending',
              color: Colors.yellow.withOpacity(0.5),
              textColor: Colors.yellow.shade900,
            ),
        ],
      ),
      onTap: onTap,
      trailing: apply.review == null
          ? const Icon(Icons.pending_outlined)
          : IconButton(
              icon: const Icon(Icons.remove_red_eye_outlined),
              onPressed: () => context.go(
                '/applies/${apply.id}/review',
                extra: apply,
              ),
            ),
    );
  }
}

class BulletText extends StatelessWidget {
  const BulletText({
    required this.text,
    required this.color,
    this.textColor,
    super.key,
  });

  final String text;
  final Color? textColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: color,
        ),
        // BoxDecoration(
        //   color: color,
        //   borderRadius: BorderRadius.circular(10),
        // ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }
}
