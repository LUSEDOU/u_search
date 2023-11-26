import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../apply.dart';

class ApplyPage extends StatelessWidget {
  const ApplyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ApplyBloc(),
      child: const ApplyView(),
    );
  }
}

class ApplyView extends StatelessWidget {
  const ApplyView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplyBloc, ApplyState>(
      builder: (context, state) {
        // TODO: return correct widget based on the state.
        return const SizedBox();
      },
    );
  }
}
