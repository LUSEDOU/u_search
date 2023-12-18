import 'dart:io';

import 'package:data_repository/data_repository.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:u_search_flutter/app/app.dart';
import 'package:u_search_flutter/apply/apply.dart';
import 'package:u_search_flutter/utils/models_extensions.dart';

class ApplyPage extends StatelessWidget {
  const ApplyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ApplyBloc(
        dataRepository: context.read<DataRepository>(),
      )..add(const ApplyFetchContests()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Apply')),
        body: MultiBlocListener(
          listeners: [
            BlocListener<ApplyBloc, ApplyState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status == ApplyStatus.failure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(content: Text('Apply Failure')),
                    );
                }
              },
            ),
            BlocListener<ApplyBloc, ApplyState>(
              listenWhen: (previous, current) =>
                  previous.apply != current.apply,
              listener: (context, state) {
                if (state.apply != null) {
                  context.go('/applies/${state.apply!.id}');
                }
              },
            ),
          ],
          child: const ApplyView(),
        ),
      ),
    );
  }
}

class ApplyView extends StatelessWidget {
  const ApplyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ApplyBloc, ApplyState>(
        builder: (context, state) {
          switch (state.step) {
            case ApplyStep.contest:
              return const ContestsView();
            case ApplyStep.research:
              return const SubmitView();
          }
        },
      ),
    );
  }
}

class ContestsView extends StatelessWidget {
  const ContestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      child: BlocBuilder<ApplyBloc, ApplyState>(
        builder: (context, state) {
          return ListView(
            children: [
              for (final contest in state.contests)
                ListTile(
                  title: Text(contest.name),
                  subtitle: Text(contest.description),
                  onTap: () => context.read<ApplyBloc>().add(
                        ApplySelectContest(contest),
                      ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class SubmitView extends StatelessWidget {
  const SubmitView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplyBloc, ApplyState>(
      builder: (context, state) {
        final researcher = context.read<AppBloc>().state.getRole<Researcher>();

        return Column(
          children: [
            if (state.research != null)
              ListTile(
                title: Text(state.research!.title),
                subtitle: Text(
                  state.research!.length.toString(),
                ),
              ),
            Center(
              child: TextButton(
                onPressed: () => FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                ).then(
                  (value) {
                    if (value == null) return;
                    context.read<ApplyBloc>().add(
                          ApplyUploadResearch(
                            file: File(value.files.single.path!),
                            researcher: researcher,
                          ),
                        );
                  },
                ),
                child: Text(
                  'Submit',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            if (state.file != null)
              Center(
                child: TextButton(
                  onPressed: () => context.read<ApplyBloc>().add(
                        const ApplySubmitApplication(),
                      ),
                  child: Text(
                    'Submit',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
