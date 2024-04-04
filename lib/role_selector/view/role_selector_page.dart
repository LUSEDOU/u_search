import 'package:authentication_repository/authentication_repository.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/app/app.dart';
import 'package:u_search_flutter/role_selector/role_selector.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';
import 'package:u_search_flutter/utils/models_extensions.dart';

class RoleSelectorPage extends StatelessWidget {
  const RoleSelectorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoleSelectorCubit(
        dataRepository: context.read<DataRepository>(),
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const RoleSelectorView(),
    );
  }
}

class RoleSelectorView extends StatelessWidget {
  const RoleSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<RoleSelectorCubit, RoleSelectorState>(
            listenWhen: (previous, current) =>
                previous.status != current.status && current.isFailure,
            listener: (context, state) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('Code is not valid '),
                  ),
                );
            },
          ),
          BlocListener<AppBloc, AppState>(
            listenWhen: (previous, current) => previous.role != current.role,
            listener: (context, state) {
              context.go('/auth');
              // context.go('/applies');
            },
          ),
        ],
        child: BlocBuilder<RoleSelectorCubit, RoleSelectorState>(
          builder: (context, state) {
            if (!state.type.isUnknown) {
              return const RoleSelectorCodeForm();
            }
            return const RoleSelectorButtons();
          },
        ),
      ),
    );
  }
}
