import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../apply_review.dart';

class ApplyReviewPage extends StatelessWidget {
  const ApplyReviewPage({
    required Apply apply,
    super.key,
  }) : _apply = apply;

  final Apply _apply;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApplyReviewBloc(
        dataRepository: context.read<DataRepository>(),
        apply: _apply,
      ),
      child: const ApplyReviewView(),
    );
  }
}

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
          return BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (state.isNew)
                  ElevatedButton(
                    onPressed: state.isValid == null
                        ? null
                        : () => context.read<ApplyReviewBloc>().add(
                              const ApplyReviewSubmit(),
                            ),
                    child: const Text('Save'),
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
              context.go(
                '/applies/${state.apply.id}/review',
                extra: state.apply,
              );
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
        child: ApplyReviewForm(),
      ),
    );
  }
}

