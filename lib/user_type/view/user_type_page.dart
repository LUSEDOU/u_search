import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/user_type/user_type.dart';

class UserTypePage extends StatelessWidget {
  const UserTypePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const UserTypeView();
  }
}

class UserTypeView extends StatelessWidget {
  const UserTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserTypeCubit, UserTypeState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == UserTypeStatus.failure,
        listener: (context, state) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Code is not valid '),
              ),
            );
        },
        builder: (context, state) {},
      ),
    );
  }
}
