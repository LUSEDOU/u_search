import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/app/app.dart';
import 'package:u_search_flutter/auth/auth.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AppStatus.authenticated) {
          context.go('/applies');
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxxlg),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Auth'),
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    return AppEmailTextField(
                      onChanged: (email) =>
                          context.read<AuthBloc>().add(AuthEmailChanged(email)),
                      hintText: 'Email',
                      suffix: IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () => context
                            .read<AuthBloc>()
                            .add(const AuthEmailSubmitted()),
                      ),
                    );
                  },
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    return RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Se ha enviado un link de acceso a ',
                          ),
                          TextSpan(
                            text: state.email.value,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
