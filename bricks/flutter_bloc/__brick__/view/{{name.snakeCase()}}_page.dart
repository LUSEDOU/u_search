import 'package:application_repository/application_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_api/client.dart';

import 'package:u_search_flutter/{{name.snakeCase()}}/{{name.snakeCase()}}.dart';

class {{name.pascalCase()}}Page extends StatelessWidget {
  const {{name.pascalCase()}}Page({ super.key });

  factory {{name.pascalCase()}}Page.routeBuilder(_, GoRouterState state) {
    final data = state.extra as {{name.pascalCase()}}Data?;

    return const {{name.pascalCase()}}Page();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final applicationRepository = context.read<ApplicationRepository>();

        final bloc = {{name.pascalCase()}}Bloc(
          applicationRepository: applicationRepository,
        );

        if (true) {
          bloc.add(const {{name.pascalCase()}}Requested());
        }

        return bloc;
      },
      child: const {{name.pascalCase()}}View(),
    );
  }
}

class {{name.pascalCase()}}Data extends Equatable {
  const {{name.pascalCase()}}Data();

  @override
  List<Object?> get props => [];
}
