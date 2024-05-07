import 'package:app_ui/app_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/app/app.dart';
import 'package:u_search_flutter/auth/auth.dart';
import 'package:user_repository/user_repository.dart';

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
                Text(
                  'Ingresar',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: AppSpacing.xlg),
                Text(
                  'Ingresa tu correo electrónico para recibir un link de acceso',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.xlg),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final status = state.status;
                    final enable = status == AuthStatus.initial ||
                        status == AuthStatus.failure;
                    return AppEmailTextField(
                      onChanged: (email) =>
                          context.read<AuthBloc>().add(AuthEmailChanged(email)),
                      hintText: 'Email',
                      readOnly: !enable,
                      suffix: IconButton(
                        icon: const Icon(Icons.send),
                        padding: EdgeInsets.zero,
                        onPressed: enable && state.isValid
                            ? () => context
                                .read<AuthBloc>()
                                .add(const AuthEmailSubmitted())
                            : null,
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.xlg),
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    final textTheme = Theme.of(context).textTheme;
                    return Visibility(
                      visible: state.status == AuthStatus.success,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Se ha enviado un link de acceso a ',
                              style: textTheme.bodyMedium,
                            ),
                            TextSpan(
                              text: state.email.value,
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.xlg),
                if (kDebugMode) const TokenField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TokenField extends StatefulWidget {
  const TokenField({super.key});

  @override
  State<TokenField> createState() => _TokenFieldState();
}

class _TokenFieldState extends State<TokenField> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == AuthStatus.success,
      builder: (context, state) {
        return Visibility(
          visible: kDebugMode && state.status == AuthStatus.success,
          child: AppEmailTextField(
            hintText: 'Token',
            controller: _controller,
            suffix: IconButton(
              icon: const Icon(Icons.send),
              padding: EdgeInsets.zero,
              onPressed: () {
                context.read<AuthBloc>().add(AuthRequested(_controller.text));
              },
            ),
          ),
        );
      },
    );
  }
}
