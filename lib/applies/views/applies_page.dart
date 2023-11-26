import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_api/u_search_api.dart';
import 'package:u_search_flutter/applies/applies.dart';
import 'package:u_search_flutter/repositories.dart';

class AppliesPage extends StatelessWidget {
  const AppliesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppliesBloc(
        dataRepository: context.read<DataRepository>(),
      )..add(const AppliesSubscriptionRequested()),
      child: const AppliesView(),
    );
  }
}

class AppliesView extends StatelessWidget {
  const AppliesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applies'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<AppliesBloc>().add(
                    const AppliesSubscriptionRequested(),
                  );
            },
          )
        ],
      ),
      body: BlocConsumer<AppliesBloc, AppliesState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == AppliesStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Applies Failure'),
                ),
              );
          }
        },
        builder: (context, state) {
          if (state.applies.isEmpty) {
            if (state.status == AppliesStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status != AppliesStatus.success) {
              return const SizedBox();
            } else {
              return const Center(
                child: Text(
                  'No Applies',
                ),
              );
            }
          }

          return CupertinoScrollbar(
            child: ListView(
              children: [
                for (final apply in state.applies)
                  ApplyTile(
                    apply: apply,
                    onTap: () => context.go('/applies/${apply.id}'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ApplyTile extends StatelessWidget {
  const ApplyTile({
    required this.apply,
    super.key,
    this.onTap,
  });

  final Apply apply;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Apply ${apply.id}'),
      onTap: onTap,
      trailing: apply.review != null
          ? const Icon(Icons.check_circle_outline)
          : const Icon(Icons.pending_outlined),
    );
  }
}
