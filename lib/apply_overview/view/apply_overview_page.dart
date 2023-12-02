import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../apply_overview.dart';

class ApplyOverviewPage extends StatelessWidget {
  const ApplyOverviewPage({
    required this.id,
    Object? apply,
    super.key,
  }) : initialApply = apply is Apply ? apply : null;

  final Apply? initialApply;
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = ApplyOverviewBloc(
          dataRepository: context.read<DataRepository>(),
          initialApply: initialApply,
        );
        if (initialApply == null) {
          bloc.add(ApplyOverviewFetchApply(id: id));
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(
            '/applies/${context.read<ApplyOverviewBloc>().state.initialApply!.id}/review'),
        child: const Icon(Icons.edit),
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
          if (state.initialApply == null) {
            if (state.status == ApplyOverviewStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status != ApplyOverviewStatus.success) {
              return const SizedBox.shrink();
            } else {
              return Center(
                child: Text(
                    'No apply with id ${state.initialApply?.id ?? 'null'}'),
              );
            }
          }
          return CupertinoScrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(state.initialApply!.id.toString()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
