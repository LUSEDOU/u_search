import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/admin/admin.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final r = await UserForm.show(context);
          if (r != null && context.mounted) {
            await context.read<UserCubit>().addUser(r);
          }
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state.status == UserStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == UserStatus.success) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  onTap: () async {
                    final r = await UserForm.show(context, user);
                    if (r != null && context.mounted) {
                      await context.read<UserCubit>().updateUser(r);
                    }
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text('Failed to fetch users'),
            );
          }
        },
      ),
    );
  }
}
