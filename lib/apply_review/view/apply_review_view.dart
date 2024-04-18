import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../apply_review.dart';

class ApplyReviewView extends StatelessWidget {
  const ApplyReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ApplyReviewBloc, ApplyReviewState>(
          builder: (context, state) {
            return Text(
              state.isNew ? 'New review' : 'Review',
            );
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<ApplyReviewBloc, ApplyReviewState>(
        builder: (context, state) {
          final score = state.totalScore;

          return BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('${state.isValid}'),
                if (state.isNew)
                  ElevatedButton(
                    onPressed: state.isValid ?? false
                        ? () => context.read<ApplyReviewBloc>().add(
                              const ApplyReviewSubmit(),
                            )
                        : null,
                    child: Text(
                      '$score',
                    ),
                  )
                else
                  Text(
                    '$score',
                  ),
              ],
            ),
          );
        },
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ApplyReviewBloc, ApplyReviewState>(
            listenWhen: (previous, current) =>
                previous.status != current.status && current.isFailure,
            listener: (context, state) {
              context.pop();

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      state.isNew
                          ? 'Failed to create review'
                          : 'Failed to save review',
                    ),
                  ),
                );
            },
          ),
          BlocListener<ApplyReviewBloc, ApplyReviewState>(
            listenWhen: (previous, current) =>
                previous.status != current.status && current.isSuccess,
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
        child: const ApplyReviewForm(),
      ),
    );
  }
}
