import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/contests/contests.dart';

class ContestEditForm extends StatefulWidget {
  const ContestEditForm({ super.key});

  @override
  State<ContestEditForm> createState() => _ContestEditFormState();
}

class _ContestEditFormState extends State<ContestEditForm> {
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
