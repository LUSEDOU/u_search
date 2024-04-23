import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../apply_review.dart';

class ApplyReviewView extends StatelessWidget {
  const ApplyReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final review = context.select((ApplyReviewBloc bloc) => bloc.state.review);
    return Scaffold(
      appBar: AppBar(
        title: Text(review.isCreated ? 'Edit Review' : 'Create Review'),
      ),
      bottomNavigationBar: _BottomNavigator(isCreated: review.isCreated),
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
              isEditable: review.isCreated,
            );
          },
        ),
      ),
    );
  }
}

class _BottomNavigator extends StatelessWidget {
  const _BottomNavigator({required this.isCreated});

  final bool isCreated;

  void _onTap(BuildContext context) {
    context.read<ApplyReviewBloc>().add(const ApplyReviewSubmit());
  }

  @override
  Widget build(BuildContext context) {
    final calification = context.select(
      (ApplyReviewBloc bloc) => bloc.state.calification,
    );
    final isValid = context.select(
      (ApplyReviewBloc bloc) => bloc.state.isValid,
    );

    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (isCreated)
            ElevatedButton(
              onPressed: isValid ? () => _onTap(context) : null,
              child: Text('${calification.score}'),
            )
          else
            Text('${calification.score}'),
        ],
      ),
    );
  }
}
