import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_view.dart';

class AppViewPage extends StatelessWidget {
  const AppViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppViewCubit(),
      child: const AppViewView(),
    );
  }
}

class AppViewView extends StatelessWidget {
  const AppViewView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppViewCubit, AppViewState>(
      builder: (context, state) {
        // TODO: return correct widget based on the state.
        return const SizedBox();
      },
    );
  }
}
