import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_api/api.dart';

import 'package:u_search_flutter/apply/apply.dart';
import 'package:user_repository/user_repository.dart';

class ApplyPage extends StatelessWidget {
  const ApplyPage({
    required this.applyId,
    this.apply,
    super.key,
  });

  factory ApplyPage.routeBuilder(_, GoRouterState state) {
    final data = state.extra as ApplyPageData?;
    final apply = data?.apply;
    final id = state.pathParameters['applyId']!;
    return ApplyPage(
      applyId: apply?.id ?? int.parse(id),
      apply: data?.apply,
    );
  }

  final int applyId;
  final Apply? apply;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final userRepository = context.read<UserRepository>();
        return ApplyBloc(userRepository: userRepository)
          ..add(const ApplyFetchContests());
      },
      child: const ApplyView(),
    );
  }
}

class ApplyPageData extends Equatable {
  const ApplyPageData({
    required this.apply,
  });

  final Apply? apply;

  @override
  List<Object?> get props => [apply];
}
