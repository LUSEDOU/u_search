import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/role_selector/role_selector.dart';

class RoleSelectorCodeForm extends StatelessWidget {
  const RoleSelectorCodeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Role Selector'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<RoleSelectorCubit>().roleTypeChanged(null);
          },
        ),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Enter your code',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          _CodeInput(),
          SizedBox(
            height: 20.0,
          ),
          _SubmitButton(),
        ],
      ),
    );
  }
}

class _CodeInput extends StatelessWidget {
  const _CodeInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoleSelectorCubit, RoleSelectorState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Code',
            errorText: state.code.displayError?.message,
            labelText: 'Code',
          ),
          onChanged: context.read<RoleSelectorCubit>().codeChanged,
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoleSelectorCubit, RoleSelectorState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.code.isValid && !state.isLoading
              ? () => context.read<RoleSelectorCubit>().roleTypeSubmitted()
              : null,
          child: state.isLoading
              ? const CircularProgressIndicator()
              : const Text('Submit'),
        );
      },
    );
  }
}
