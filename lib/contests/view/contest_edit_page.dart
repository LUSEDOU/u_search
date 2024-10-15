import 'package:application_repository/application_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_api/client.dart';

import 'package:u_search_flutter/contests/contests.dart';

class ContestEditPage extends StatelessWidget {
  const ContestEditPage({super.key});

  factory ContestEditPage.routeBuilder(_, GoRouterState state) {
    final data = state.extra as ContestEditData?;

    return const ContestEditPage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final applicationRepository = context.read<ApplicationRepository>();

        final bloc = ContestEditBloc(
          applicationRepository: applicationRepository,
        );

        if (true) {
          bloc.add(const ContestEditRequested());
        }

        return bloc;
      },
      child: const ContestEditView(),
    );
  }
}

class ContestEditData extends Equatable {
  const ContestEditData();

  @override
  List<Object?> get props => [];
}
