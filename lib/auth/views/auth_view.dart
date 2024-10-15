import 'package:app_ui/app_ui.dart';
import 'package:flutter/foundation.dart';
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
      child: const Scaffold(
        body: Padding(
          padding: EdgeInsets.all(AppSpacing.xxxlg),
          child: Center(
            child: _AuthForm(),
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

class _AuthForm extends StatefulWidget {
  const _AuthForm();

  @override
  State<_AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<_AuthForm> {
  late final GlobalKey<FormState> _formEmailKey;

  @override
  void initState() {
    super.initState();
    _formEmailKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBox(
          width: 500,
          child: Form(
            key: _formEmailKey,
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final status = state.status;
                final enable = status == AuthStatus.initial ||
                    status == AuthStatus.failure;
                return AppEmailTextField(
                  onSaved: (email) => email?.isEmpty ?? true
                      ? null
                      : context
                          .read<AuthBloc>()
                          .add(AuthEmailSubmitted(email!)),
                  hintText: 'Email',
                  readOnly: !enable,
                  autofocus: enable,
                  suffix: IconButton(
                    icon: const Icon(Icons.send),
                    padding: EdgeInsets.zero,
                    onPressed: _formEmailKey.currentState?.save,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xlg),
        BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) => previous.status != current.status,
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
        if (kDebugMode)
          const SizedBox(
            width: 500,
            child:  TokenField(),
          ),
      ],
    );
  }
}
