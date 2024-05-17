import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_api/api.dart';
import 'package:u_search_flutter/app/bloc/app_bloc.dart';
import 'package:u_search_flutter/apply_overview/apply_overview.dart';
import 'package:u_search_flutter/apply_review/view/view.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

class ApplyOverviewView extends StatelessWidget {
  const ApplyOverviewView({
    required this.role,
    super.key,
  });

  final Role role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocBuilder<ApplyOverviewBloc, ApplyOverviewState>(
        buildWhen: (previous, current) => previous.apply != current.apply,
        builder: (context, state) {
          final apply = state.apply;
          return Visibility(
            visible: apply.isReviewed || role.isReviewer,
            child: FloatingActionButton.large(
              onPressed: () => context.go(
                '/applies/${apply.id}/review',
                extra: ApplyReviewData(review: apply.review, apply: apply),
              ),
              child: const Icon(Icons.rate_review),
            ),
          );
        },
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ApplyOverviewBloc, ApplyOverviewState>(
            listenWhen: (previous, current) =>
                previous.status != current.status && current.status.isFailure,
            listener: (context, state) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('Unable to load apply')),
                );
            },
          ),
        ],
        child: BlocBuilder<ApplyOverviewBloc, ApplyOverviewState>(
          builder: (context, state) {
            final apply = context.select(
              (ApplyOverviewBloc bloc) => bloc.state.apply,
            );

            if (apply.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return CupertinoScrollbar(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xxxlg),
                  child: Center(
                    child: IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Hero(
                              tag: '__hero_apply_${apply.id}',
                              child: Text(
                                'Application #${apply.id}',
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xlg),
                          ContestTile(contest: apply.contest),
                          const SizedBox(height: AppSpacing.xlg),
                          Text(
                            'Evaluador',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          ReviewerTile(
                            canEdit: role.isAdmin &&
                                (apply.reviewer?.isAnonymous ?? true),
                          ),
                          SaveReviewerButton(role: role),
                          const SizedBox(height: AppSpacing.xxlg),
                          Text(
                            'Trabajo de Investigación',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          ResearchTile(research: apply.research),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ContestTile extends StatelessWidget {
  const ContestTile({
    required Contest contest,
    super.key,
  }) : _contest = contest;

  final Contest _contest;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        _contest.name,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      subtitle: Text(
        _contest.description,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

class ReviewerTile extends StatelessWidget {
  const ReviewerTile({
    required this.canEdit,
    super.key,
  });

  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    final reviewer =
        context.select((ApplyOverviewBloc bloc) => bloc.state.reviewer);

    if (reviewer?.isAnonymous ?? true) {
      if (!canEdit) {
        return const Text('No Evaluador');
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.xlg),
        child: AppButton.smallDarkAqua(
          child: const Text('Agregar evaluador'),
          onPressed: () async {
            final evaluator = await EvaluatorsDialog.show(context);
            if (!context.mounted) return;

            context
                .read<ApplyOverviewBloc>()
                .add(ApplyOverviewReviewerChanged(evaluator));
          },
        ),
      );
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text('${reviewer!.name} ${reviewer.lastName}'),
        subtitle: Text(reviewer.email),
        trailing: Visibility(
          visible: canEdit,
          child: IconButton(
            onPressed: () => context
                .read<ApplyOverviewBloc>()
                .add(const ApplyOverviewReviewerChanged(null)),
            icon: const Icon(Icons.clear),
          ),
        ),
      ),
    );
  }
}

class ResearchTile extends StatelessWidget {
  const ResearchTile({
    required Research research,
    super.key,
  }) : _research = research;
  final Research _research;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: ListTile(
        title: Text(_research.title),
        subtitle: Text('${_research.length} kb'),
        trailing: IconButton(
          onPressed: () => context
              .read<ApplyOverviewBloc>()
              .add(const ApplyOverviewDownloadRequested()),
          icon: const Icon(Icons.download),
        ),
      ),
    );
  }
}

class SaveReviewerButton extends StatelessWidget {
  const SaveReviewerButton({required this.role, super.key});

  final Role role;

  @override
  Widget build(BuildContext context) {
    final apply = context.select((ApplyOverviewBloc bloc) => bloc.state.apply);

    if (!role.isAdmin || apply.reviewer != null) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<ApplyOverviewBloc, ApplyOverviewState>(
      buildWhen: (previous, current) => previous.reviewer != current.reviewer,
      builder: (context, state) {
        final reviewer = state.reviewer;

        return Visibility(
          visible: reviewer != null,
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: AppButton.darkAqua(
                child: const Padding(
                  padding: EdgeInsets.all(AppSpacing.xs),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.save),
                      Text('Guardar y Enviar evaluación'),
                    ],
                  ),
                ),
                onPressed: () => context
                    .read<ApplyOverviewBloc>()
                    .add(const ApplyOverviewSubmit()),
              ),
            ),
          ),
        );
      },
    );
  }
}
