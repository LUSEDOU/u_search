import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_api/api.dart';
import 'package:u_search_flutter/app/app.dart';
import 'package:u_search_flutter/apply_overview/apply_overview.dart';
import 'package:u_search_flutter/apply_overview/bloc/apply_overview_bloc.dart';

class ApplyOverviewView extends StatelessWidget {
  const ApplyOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply Overview'),
      ),
      floatingActionButton: BlocBuilder<ApplyOverviewBloc, ApplyOverviewState>(
        buildWhen: (previous, current) => previous.apply != current.apply,
        builder: (context, state) {
          final apply = state.apply;
          return Visibility(
            visible: !apply.isEmpty && !apply.isReviewed,
            child: FloatingActionButton(
              onPressed: () => context.go(
                '/applies/${apply.id}/review',
                extra: state.apply,
              ),
              child: const Icon(Icons.edit),
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
                child: Column(
                  children: [
                    Text('id: ${apply.id}'),
                    const SizedBox(height: 8),
                    ContestTile(contest: apply.contest),
                    const SizedBox(height: 8),
                    AppButton.blueDress(
                      child: const Text('Select Evaluator'),
                      onPressed: () async {
                        final evaluator = await EvaluatorsDialog.show(context);
                        if (!context.mounted) return;

                        context
                            .read<ApplyOverviewBloc>()
                            .add(ApplyOverviewReviewerChanged(evaluator));
                      },
                    ),
                    const SizedBox(height: 8),
                    ResearchTile(research: apply.research),
                    const SizedBox(height: 8),
                    AppButton.blueDress(
                      child: const Text('Download'),
                      onPressed: () => context
                          .read<ApplyOverviewBloc>()
                          .add(const ApplyOverviewDownloadRequested()),
                    ),
                  ],
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
      title: Text(_contest.name),
      subtitle: Text(_contest.description),
    );
  }
}

class EvaluatorTile extends StatelessWidget {
  const EvaluatorTile({
    required User reviewer,
    super.key,
  }) : _evaluator = reviewer;

  final User _evaluator;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_evaluator.user.name),
      subtitle: Text(_evaluator.user.email),
      trailing: context.read<AppBloc>().state.role.isAdmin
          ? IconButton(
              onPressed: () => context.read<ApplyOverviewBloc>().add(
                    ApplyOverviewDeleteEvaluator(),
                  ),
              icon: const Icon(Icons.delete),
            )
          : null,
    );
  }
}

class EmptyEvaluatorTile extends StatelessWidget {
  const EmptyEvaluatorTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text('No reviewer'),
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
    return ListTile(
      title: Text(_research.title),
      subtitle: Text('${_research.length} kb'),
    );
  }
}

class DownloadButton extends StatelessWidget {
  const DownloadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplyOverviewBloc, ApplyOverviewState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {},
          child: state.status.isLoading
              ? const Text('Download')
              : const CircularProgressIndicator(),
        );
      },
    );
  }
}
