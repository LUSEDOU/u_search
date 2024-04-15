import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/app/app.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';
import 'package:u_search_flutter/utils/models_extensions.dart';

import '../apply_overview.dart';

class ApplyOverviewPage extends StatelessWidget {
  const ApplyOverviewPage({
    required int id,
    Apply? apply,
    super.key,
  })  : _apply = apply,
        _id = id;

  final Apply? _apply;
  final int _id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = ApplyOverviewBloc(
          dataRepository: context.read<DataRepository>(),
          apply: _apply,
        );
        if (_apply == null) {
          bloc.add(ApplyOverviewFetchApply(id: _id));
        }
        if (context.read<AppBloc>().state.role.isAdmin) {
          bloc.add(const ApplyOverviewFetchEvaluators());
        }
        return bloc;
      },
      child: const ApplyOverviewView(),
    );
  }
}
