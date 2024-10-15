import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/{{name.snakeCase()}}/{{name.snakeCase()}}.dart';

class {{name.pascalCase()}}Form extends StatefulWidget {
  const {{name.pascalCase()}}Form({ super.key});

  @override
  State<{{name.pascalCase()}}Form> createState() => _{{name.pascalCase()}}FormState();
}

class _{{name.pascalCase()}}FormState extends State<{{name.pascalCase()}}Form> {
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Placeholder(),
    );
  }
}
