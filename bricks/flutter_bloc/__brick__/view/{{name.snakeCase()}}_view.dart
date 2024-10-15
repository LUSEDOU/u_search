import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/{{name.snakeCase()}}/{{name.snakeCase()}}.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

class {{name.pascalCase()}}View extends StatelessWidget {
  const {{name.pascalCase()}}View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<{{name.pascalCase()}}Bloc, {{name.pascalCase()}}State>(
            listenWhen: (previous, current) =>
                previous.status != current.status &&
                current.status == {{name.pascalCase()}}Status.failure,
            listener: (context, state) {
              context.pop();

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      'Ha ocurrido un error',
                    ),
                  ),
                );
            },
          ),
          BlocListener<{{name.pascalCase()}}Bloc, {{name.pascalCase()}}State>(
            listenWhen: (previous, current) =>
                previous.status != current.status &&
                current.status == {{name.pascalCase()}}Status.success,
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
        child: const {{name.pascalCase()}}Form(),
      ),
    );
  }
}
