import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/auth/auth.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Center(
          child: BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Auth'),
                  AppEmailTextField(
                    onChanged: (email) =>
                        context.read<AuthBloc>().add(AuthEmailChanged(email)),
                    hintText: 'Email',
                    suffix: IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () => context
                          .read<AuthBloc>()
                          .add(const AutheEmailSubmitted()),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
