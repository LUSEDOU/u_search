import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/applies_overview/applies_overview.dart';

class ApplyOverviewPage extends StatelessWidget {
  const ApplyOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppliesOverviewBloc(
        dataRepository: RepositoryProvider.of<DataRepository>(context),
      ),
      child: const ApplyOverviewView(),
    );
  }
}

class ApplyOverviewView extends StatelessWidget {
  const ApplyOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Applies'),
      ),
      child: Center(
        child: Text('Applies Overview'),
      ),
    );
  }
}
