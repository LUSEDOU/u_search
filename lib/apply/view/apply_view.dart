import 'package:app_ui/app_ui.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:u_search_flutter/apply/apply.dart';

class ApplyView extends StatelessWidget {
  const ApplyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apply')),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ApplyBloc, ApplyState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              switch (state.status) {
                case ApplyStatus.failure:
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(content: Text('Apply Failure')),
                    );
                case ApplyStatus.success:
                  return context.go('/applies');
                case _:
              }
            },
          ),
        ],
        child: const SubmitView(),
      ),
    );
  }
}

class SubmitView extends StatelessWidget {
  const SubmitView({super.key});

  @override
  Widget build(BuildContext context) {
    final submitButton = AppButton.darkAqua(
      child: const Text('Pick a file'),
      onPressed: () async {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );
        final document = result?.files.firstOrNull;

        if (!context.mounted || document == null) return;

        context.read<ApplyBloc>().add(ApplyLoadFile(file: document));
      },
    );
    return BlocBuilder<ApplyBloc, ApplyState>(
      builder: (context, state) {
        final file = state.file;

        if (file == null) {
          return Center(
            child: submitButton,
          );
        }

        return Column(
          children: [
            Text(
              file.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              file.size.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Center(child: submitButton),
            const SizedBox(height: 8),
            AppButton.darkAqua(
              child: const Text('Submit'),
              onPressed: () {
                context.read<ApplyBloc>().add(const ApplySubmissionRequested());
              },
            ),
          ],
        );
      },
    );
  }
}
