import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/welcome/welcome.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  factory WelcomePage.routeBuilder(BuildContext _, GoRouterState __) =>
      const WelcomePage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WelcomeCubit(),
      child: const WelcomeView(),
    );
  }
}

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Center(
          child: BlocBuilder<WelcomeCubit, WelcomeState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              final status = state.status;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Welcome'),
                  Visibility(
                    visible: status.isSuccess,
                    child: const _SubmittedContent(),
                  ),
                  const _EmailForm(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SubmittedContent extends StatelessWidget {
  const _SubmittedContent();

  @override
  Widget build(BuildContext context) {
    return const Text('Success');
  }
}

class _EmailForm extends StatelessWidget {
  const _EmailForm();

  @override
  Widget build(BuildContext context) {
    final email = context.select(
      (WelcomeCubit cubit) => cubit.state.email,
    );
    final status = context.select(
      (WelcomeCubit cubit) => cubit.state.status,
    );

    return AppEmailTextField(
      onChanged: context.read<WelcomeCubit>().emailChanged,
      hintText: 'Email',
      readOnly: status.isSuccess,
      suffix: Visibility(
        visible: !status.isSuccess,
        child: IconButton(
          onPressed: email.isValid ? context.read<WelcomeCubit>().submit : null,
          icon: const Icon(Icons.send),
        ),
      ),
    );
  }
}
