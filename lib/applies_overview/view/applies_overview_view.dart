import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_api/api.dart';
import 'package:u_search_flutter/app/app.dart';

import 'package:u_search_flutter/applies_overview/applies_overview.dart';
import 'package:u_search_flutter/applies_overview/view/scaffold_with_nav_bar.dart';
import 'package:u_search_flutter/apply_overview/apply_overview.dart';
import 'package:u_search_flutter/contests/view/view.dart';

class AppliesOverviewView extends StatelessWidget {
  const AppliesOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('USIL'),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(
          '/contests',
          extra: const ContestsData(redirectToApply: true),
        ),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxlg),
        child: BlocConsumer<AppliesOverviewBloc, AppliesOverviewState>(
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
                    'You have no applies',
                    // role.isReviewer
                    //     ? 'Wait until we assign you an apply'
                    //     : 'You have no applies',
                  ),
                );
              }
            }

            return CupertinoScrollbar(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WelcomeText(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.applies.length,
                      itemBuilder: (context, index) {
                        final apply = state.applies[index];
                        return ApplyTile(
                          apply: apply,
                          onTap: () => context.go(
                            '/applies/${apply.id}',
                            extra: ApplyOverviewData(apply: apply),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
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
    final user = context.read<AppBloc>().user;
    final theme = Theme.of(context);

    return Visibility(
      // visible: user.isAnonymous,
      child: Text(
        'Bienvenido ${user.name}',
        style: theme.textTheme.titleLarge,
      ),
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
    final color = apply.isReviewed ? Colors.green : Colors.grey;
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      title: Row(
        children: [
          Hero(
            tag: '__hero_apply_${apply.id}',
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '#${apply.id}',
                    style: textTheme.titleMedium,
                  ),
                  TextSpan(
                    text: ' - ${apply.research.title}',
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          BulletText(
            text: apply.status.label,
            color: color.withOpacity(0.2),
            textColor: color,
          ),
        ],
      ),
      subtitle: Text(
        apply.contest.name,
        style: textTheme.bodySmall,
      ),
      onTap: onTap,
      trailing: apply.review == null
          ? const Padding(
              padding: EdgeInsets.all(AppSpacing.sm),
              // pending icon
              child: Icon(Icons.pending_actions),
            )
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: color,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 10, color: textColor),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
