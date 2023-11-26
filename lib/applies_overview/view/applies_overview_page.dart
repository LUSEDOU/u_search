import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../applies_overview.dart';

class AppliesOverviewPage extends StatelessWidget {
  const AppliesOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppliesOverviewBloc(),
      child: const AppliesOverviewView(),
    );
  }
}

class AppliesOverviewView extends StatelessWidget {
  const AppliesOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppliesOverviewBloc, AppliesOverviewState>(
      builder: (context, state) {
        // TODO: return correct widget based on the state.
        return const SizedBox();
      },
    );
  }
}
