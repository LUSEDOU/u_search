import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/app/app.dart';
import 'package:u_search_flutter/apply_overview/apply_overview.dart';

class ApplyOverviewView extends StatelessWidget {
  const ApplyOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final role = context.read<AppBloc>().state.role;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply Overview'),
      ),
      floatingActionButton: BlocBuilder<ApplyOverviewBloc, ApplyOverviewState>(
        builder: (context, state) {
          if (state.apply == null) {
            return const SizedBox.shrink();
          }

          return FloatingActionButton(
            onPressed: () => context.go(
              '/applies/${state.apply!.id}/review',
              extra: state.apply,
            ),
            child: const Icon(Icons.edit),
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
            if (state.apply == null) {
              if (state.status == ApplyOverviewStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status != ApplyOverviewStatus.success) {
                return const SizedBox.shrink();
              } else {
                return Center(
                  child: Text('No apply with id ${state.apply?.id ?? 'null'}'),
                );
              }
            }
            return CupertinoScrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('id: ${state.apply!.id}'),
                    const SizedBox(height: 8),
                    ContestTile(contest: state.apply!.contest),
                    const SizedBox(height: 8),
                    if (state.reviewer != null)
                      EvaluatorTile(
                        reviewer: state.reviewer!,
                      )
                    else
                      const EvaluatorList(),
                    const SizedBox(height: 8),
                    ResearchTile(research: state.apply!.research!),
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
    required Role reviewer,
    super.key,
  }) : _evaluator = reviewer;

  final Role _evaluator;

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
        if (state.apply == null) {
          return const SizedBox.shrink();
        }
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

class EvaluatorList extends StatelessWidget {
  const EvaluatorList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplyOverviewBloc, ApplyOverviewState>(
      builder: (context, state) {
        if (state.evaluators.isEmpty) {
          return const SizedBox.shrink();
        }

        return CupertinoScrollbar(
          child: SingleChildScrollView(
            child: Row(
              children: [
                for (final evaluator in state.evaluators)
                  EvaluatorCard(evaluator: evaluator),
              ],
            ),
          ),
        );
      },
    );
  }
}

class EvaluatorCard extends StatelessWidget {
  const EvaluatorCard({
    required this.evaluator,
    super.key,
  });

  final Role evaluator;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(evaluator.user.name),
        subtitle: Text(evaluator.user.email),
      ),
    );
  }
}
