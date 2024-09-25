import 'package:application_repository/application_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/admin/admin.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(
        applicationRepository:
            RepositoryProvider.of<ApplicationRepository>(context),
      )..fetchUsers(),
      child: const UsersView(),
    );
  }
}
