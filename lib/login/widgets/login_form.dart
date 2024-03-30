import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/login/bloc/login_bloc.dart';
import 'package:u_search_flutter/login/login.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.error ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: const Align(
        alignment: Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _EmailInput(),
              _NextButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatefulWidget {
  const _EmailInput();

  @override
  State<_EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<_EmailInput> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginBloc>().state;

    return AppEmailTextField(
      key: const Key('loginWithEmailForm_emailInput_textField'),
      controller: _controller,
      readOnly: state.status.isInProgress,
      // hintText: context.l10n.loginWithEmailTextFieldHint,
      onChanged: (email) =>
          context.read<LoginBloc>().add(LoginEmailChanged(email)),
      suffix: ClearIconButton(
        onPressed: !state.status.isInProgress
            ? () {
                _controller.clear();
                context.read<LoginBloc>().add(const LoginEmailChanged(''));
              }
            : null,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton();

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    final state = context.watch<LoginBloc>().state;

    return AppButton.darkAqua(
      key: const Key('loginWithEmailForm_nextButton'),
      onPressed: state.isValid
          ? () => context.read<LoginBloc>().add(const LoginSendEmailLink())
          : null,
      child: state.status.isInProgress
          ? const SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(),
            )
          : const Text('Next'),
    );
  }
}

@visibleForTesting
class ClearIconButton extends StatelessWidget {
  const ClearIconButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final suffixVisible =
        context.select((LoginBloc bloc) => bloc.state.email.value.isNotEmpty);

    return Padding(
      key: const Key('loginWithEmailForm_clearIconButton'),
      padding: const EdgeInsets.only(right: AppSpacing.md),
      child: Visibility(
        visible: suffixVisible,
        child: GestureDetector(
          onTap: onPressed,
          // child: Assets.icons.closeCircle.svg(),
          child: const Icon(Icons.close),
        ),
      ),
    );
  }
}
