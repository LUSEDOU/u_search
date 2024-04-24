import 'package:application_repository/application_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_api/api.dart';
import 'package:u_search_flutter/app/app.dart';

import '../apply_overview.dart';

class ApplyOverviewPage extends StatelessWidget {
  const ApplyOverviewPage({
    required int id,
    Apply? apply,
    super.key,
  })  : _apply = apply,
        _id = id;

  factory ApplyOverviewPage.routeBuilder(_, GoRouterState state) {
    final data = state.extra as ApplyOverviewData?;
    final id = int.parse(state.pathParameters['applyId']!);

    return ApplyOverviewPage(
      id: id,
      apply: data?.apply,
      key: const Key('applyOverview'),
    );
  }

  final Apply? _apply;
  final int _id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final applicationRepository = context.read<ApplicationRepository>();
        final bloc = ApplyOverviewBloc(
          applicationRepository: applicationRepository,
          apply: _apply ?? Apply.empty,
        );
        if (_apply == null) {
          bloc.add(ApplyOverviewRequested(id: _id));
        }
        return bloc;
      },
      child: ApplyOverviewView(
        role: context.read<User>().role,
      ),
    );
  }
}

class ApplyOverviewData extends Equatable {
  const ApplyOverviewData({
    required this.apply,
  });

  final Apply apply;

  @override
  List<Object> get props => [apply];
}
