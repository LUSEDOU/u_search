import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../apply_review.dart';

class ApplyReviewPage extends StatelessWidget {
  const ApplyReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ApplyReviewBloc(),
      child: const ApplyReviewView(),
    );
  }
}

class ApplyReviewView extends StatelessWidget {
  const ApplyReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplyReviewBloc, ApplyReviewState>(
      builder: (context, state) {
        // TODO: return correct widget based on the state.
        return const SizedBox();
      },
    );
  }
}
