import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/role_selector/role_selector.dart';
import 'package:u_search_flutter/utils/dart_extensions.dart';

class RoleSelectorButtons extends StatelessWidget {
  const RoleSelectorButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = context.height;

    return CupertinoScrollbar(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Select your account type',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            for (final type in RoleType.permitted)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _RoleTypeButton(
                    type: type,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _RoleTypeButton extends StatelessWidget {
  const _RoleTypeButton({
    required this.type,
  });

  final RoleType type;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.all(16.0),
        ),
        onPressed: () =>
            context.read<RoleSelectorCubit>().roleTypeChanged(type),
        child: Text(
          type.name,
          style: const TextStyle(
            fontSize: 40.0,
          ),
        ),
      ),
    );
  }
}
