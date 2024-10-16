import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/contests/contests.dart';

class ContestEditView extends StatelessWidget {
  const ContestEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<ContestEditBloc, ContestEditState>(
            listenWhen: (previous, current) =>
                previous.status != current.status &&
                current.status == ContestEditStatus.failure,
            listener: (context, state) {
              context.pop();

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Ha ocurrido un error',
                    ),
                  ),
                );
            },
          ),
          BlocListener<ContestEditBloc, ContestEditState>(
            listenWhen: (previous, current) =>
                previous.status != current.status &&
                current.status == ContestEditStatus.success,
            listener: (context, state) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('Feedback enviado!'),
                  ),
                );
            },
          ),
        ],
        child: const ContestEditForm(),
      ),
    );
  }
}
