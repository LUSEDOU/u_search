import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../apply_overview.dart';

class ApplyOverviewPage extends StatelessWidget {
  const ApplyOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ApplyOverviewCubit(),
      child: const ApplyOverviewView(),
    );
  }
}

class ApplyOverviewView extends StatelessWidget {
  const ApplyOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplyOverviewCubit, ApplyOverviewState>(
      builder: (context, state) {
        // TODO: return correct widget based on the state.
        return const SizedBox();
      },
    );
  }
}
