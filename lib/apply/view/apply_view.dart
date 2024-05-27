import 'package:app_ui/app_ui.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:u_search_flutter/apply/apply.dart';
import 'package:u_search_flutter/apply_overview/apply_overview.dart';

class ApplyView extends StatelessWidget {
  const ApplyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                case ApplyStatus.finished:
                  final apply = state.apply;
                  return context.go(
                    '/applies/${apply.id}',
                    extra: ApplyOverviewData(apply: apply),
                  );
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

  Future<void> _onPickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    final document = result?.files.firstOrNull;

    if (!context.mounted || document == null) return;

    context.read<ApplyBloc>().add(ApplyLoadFile(file: document));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<ApplyBloc, ApplyState>(
            builder: (context, state) {
              final contest = state.contest;
              final text = contest.isEmpty ? '' : contest.name;
              return Text(
                'Aplica a la convocatoria $text',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              );
            },
          ),
          Text(
            'Sube tu archivo en formato PDF',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxxlg),
          BlocBuilder<ApplyBloc, ApplyState>(
            builder: (context, state) {
              final file = state.file;

              if (file == null) {
                return Center(
                  child: SizedBox(
                    width: size.width * 0.3,
                    child: AppButton.darkAqua(
                      child: const Text('Elige un archivo'),
                      onPressed: () => _onPickFile(context),
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  Text(
                    file.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    '${(file.size / 1024 / 1024).toStringAsFixed(2)} MB',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: AppSpacing.xlg),
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.green,
                    size: 48,
                  ),
                  const SizedBox(height: AppSpacing.xlg),
                  SizedBox(
                    width: size.width * 0.3,
                    child: AppButton.crystalBlue(
                      child: const Text('Seleccionar otro archivo'),
                      onPressed: () => _onPickFile(context),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xlg),
                  SizedBox(
                    width: size.width * 0.3,
                    child: AppButton.darkAqua(
                      child: const Text('Enviar'),
                      onPressed: () {
                        context
                            .read<ApplyBloc>()
                            .add(const ApplySubmissionRequested());
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
