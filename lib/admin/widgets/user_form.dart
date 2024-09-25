import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_api/api.dart';
import 'package:u_search_flutter/utils/dart_extensions.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key, this.user});

  final User? user;

  static Future<User?> show(BuildContext context, [User? user]) {
    return showDialog(
      context: context,
      builder: Dialog(child: UserForm(user: user)).build,
    );
  }

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late int _selectedRoleIndex;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController(text: widget.user?.name);
    _lastNameController = TextEditingController(text: widget.user?.lastName);
    _emailController = TextEditingController(text: widget.user?.email);
    _selectedRoleIndex = widget.user?.role.index ?? -1;
  }

  @override
  Widget build(BuildContext context) {
    final canOperate = widget.user != null;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xlg),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _nameController,
                    isRequired: true,
                    label: 'Nombre',
                    suffix: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(width: AppSpacing.xlg),
                Expanded(
                  child: AppTextField(
                    controller: _lastNameController,
                    isRequired: true,
                    label: 'Apellido',
                    suffix: const Icon(Icons.person),
                  ),
                ),
              ],
            ),
            AppTextField(
              controller: _emailController,
              isRequired: true,
              label: 'Correo electrónico',
              suffix: const Icon(Icons.email),
            ),
            // const SizedBox(height: AppSpacing.xlg),
            DropdownMenu<int>(
              initialSelection: _selectedRoleIndex,
              enableSearch: false,
              onSelected: (value) =>
                  _selectedRoleIndex = value ?? _selectedRoleIndex,
              label: const Text('Rol'),
              dropdownMenuEntries: Role.values
                  .map(
                    (role) => DropdownMenuEntry(
                      value: role.value,
                      label: role.label,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: AppSpacing.xlg),
            Row(
              children: [
                Expanded(
                  child: AppButton.outlinedWhite(
                    onPressed: canOperate ? () {} : null,
                    child: const Text('Cerrar Sesion'),
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: AppButton.darkAqua(
                    onPressed: canOperate ? () {} : null,
                    child: const Text('Enviar correo'),
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: AppButton.darkAqua(
                    child: Text(canOperate ? 'Editar' : 'Crear'),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      final role = Role.values.firstWhereOrNull(
                        (role) => role.value == _selectedRoleIndex,
                      );

                      if (role == null || role == Role.none) {
                        return;
                      }

                      final user = (widget.user ?? User.anonymous).copyWith(
                        name: _nameController.text,
                        lastName: _lastNameController.text,
                        email: _emailController.text,
                      );
                      Navigator.of(context).pop(user);
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: AppButton.outlinedWhite(
                    onPressed: context.pop,
                    child: const Text('Cancelar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
