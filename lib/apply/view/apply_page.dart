import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/app/app.dart';

import '../apply.dart';

class ApplyPage extends StatelessWidget {
  const ApplyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ApplyBloc(
        dataRepository: context.read<DataRepository>(),
        applicantId: context.read<AppBloc>().state.user.applicantId ?? 0,
      ),
      child: const ApplyView(),
    );
  }
}

class ApplyView extends StatelessWidget {
  const ApplyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ApplyBloc, ApplyState>(
        builder: (context, state) {
          return const SizedBox();
        },
      ),
    );
  }
}
