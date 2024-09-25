import 'package:application_repository/application_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_api/api.dart';
import 'package:u_search_flutter/admin/admin.dart';
import 'package:u_search_flutter/contests/contests.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({
    super.key,
  });

  factory AdminPage.routeBuilder(_, GoRouterState state) {
    final data = state.extra as AdminData?;
    return AdminPage(
      key: const Key('admin'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AdminView();
    // return BlocProvider(
    //   create: (context) {
    //     final applicationRepository = context.read<ApplicationRepository>();
    //     final bloc = AdminBloc(
    //       contest: contest,
    //       applicationRepository: applicationRepository,
    //     );
    //
    //     if (contest == null) {
    //       bloc.add(AdminFetchContest(contestId));
    //     }
    //
    //     return bloc;
    //   },
    //   child: const AdminView(),
    // );
  }
}

class AdminData extends Equatable {
  const AdminData();

  @override
  List<Object?> get props => [];
}
