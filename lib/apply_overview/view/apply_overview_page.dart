import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../apply_overview.dart';

class ApplyOverviewPage extends StatelessWidget {
  const ApplyOverviewPage({
    required int id,
    Apply? apply,
    super.key,
  })  : _apply = apply,
        _id = id;

  final Apply? _apply;
  final int _id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = ApplyOverviewBloc(
          dataRepository: context.read<DataRepository>(),
          apply: _apply,
        );
        if (_apply == null) {
          bloc.add(ApplyOverviewFetchApply(id: _id));
        }
        return bloc;
      },
      child: const ApplyOverviewView(),
    );
  }
}

class ApplyOverviewView extends StatelessWidget {
  const ApplyOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: BlocConsumer<ApplyOverviewBloc, ApplyOverviewState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == ApplyOverviewStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Unable to load apply')),
              );
          }
        },
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
                  if (state.apply!.evaluator != null)
                    EvaluatorTile(
                      evaluator: state.apply!.evaluator!,
                    )
                  else
                    const EmptyEvaluatorTile(),
                  const SizedBox(height: 8),
                  ResearchTile(research: state.apply!.research!),
                ],
              ),
            ),
          );
        },
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
    required User evaluator,
    super.key,
  }) : _evaluator = evaluator;

  final User _evaluator;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_evaluator.name),
      subtitle: Text(_evaluator.email),
    );
  }
}

class EmptyEvaluatorTile extends StatelessWidget {
  const EmptyEvaluatorTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text('No evaluator'),
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
