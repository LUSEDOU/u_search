import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

class ApplyReviewView extends StatelessWidget {
  const ApplyReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final review = context.select((ApplyReviewBloc bloc) => bloc.state.review);
    final isEditable = !review.isCreated;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      bottomNavigationBar: _BottomNavigator(
        isCreated: review.isCreated,
        formKey: formKey,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ApplyReviewBloc, ApplyReviewState>(
            listenWhen: (previous, current) =>
                previous.status != current.status &&
                current.status == ApplyReviewStatus.failure,
            listener: (context, state) {
              context.pop();

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      state.review.isCreated
                          ? 'Failed to create review'
                          : 'Failed to save review',
                    ),
                  ),
                );
            },
          ),
          BlocListener<ApplyReviewBloc, ApplyReviewState>(
            listenWhen: (previous, current) =>
                previous.status != current.status &&
                current.status == ApplyReviewStatus.success,
            listener: (context, state) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('Review saved'),
                  ),
                );
            },
          ),
        ],
        child: BlocBuilder<ApplyReviewBloc, ApplyReviewState>(
          buildWhen: (previous, current) => previous.review != current.review,
          builder: (context, state) {
            final calification = state.calification;
            return ApplyReviewForm(
              node: calification,
              isEditable: isEditable,
              formKey: formKey,
            );
          },
        ),
      ),
    );
  }
}

class _BottomNavigator extends StatelessWidget {
  const _BottomNavigator({
    required this.isCreated,
    required this.formKey,
  });

  final bool isCreated;
  final GlobalKey<FormState> formKey;

  void _onTap(BuildContext context) {
    formKey.currentState?.save();
    context.read<ApplyReviewBloc>().add(const ApplyReviewSubmit());
  }

  @override
  Widget build(BuildContext context) {
    final calification = context.select(
      (ApplyReviewBloc bloc) => bloc.state.calification.score,
    );
    LoggerManager().i('BottomNavigator build');

    return BottomAppBar(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xxxlg, vertical: AppSpacing.md,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (!isCreated)
            ElevatedButton(
              onPressed: () => _onTap(context),
              child: Text('Calificar ${calification.value}'),
            )
          else
            Container(
              decoration: ShapeDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: const StadiumBorder(),
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                child: Text(
                  'Calificación: ${calification.value}',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
