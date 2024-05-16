import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_api/api.dart';
import 'package:u_search_flutter/contests/contests.dart';

class ContestView extends StatelessWidget {
  const ContestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ContestBloc, ContestState>(
        listener: (context, state) {
          if (state.status == ContestStatus.failure) {
            context.pop();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Concurso no disponible')),
              );
          }
        },
        builder: (context, state) {
          final status = state.status;
          final contest = state.contest;

          if (status != ContestStatus.success) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              Text(contest.name),
              Text(contest.description),
            ],
          );
        },
      ),
    );
  }
}
