import 'package:flutter/widgets.dart';


enum {{name.pascalCase()}}Status { initial, loading, success, failure }

class {{name.pascalCase()}}Page extends StatelessWidget {
  const {{name.pascalCase()}}Page({
      {{name.pascalCase()}}Status status = {{name.pascalCase()}}Status.initial,
      super.key,
  });

  final {{name.pascalCase()}}Status status;

  @override
  Widget build(BuildContext context) {
{{#is_bloc}}{{> bloc_provider }}{{/is_bloc}}{{^is_bloc}}{{> cubit_bloc_provider }}{{/is_bloc}}
  }
}

class {{name.pascalCase()}}View extends StatelessWidget {
  const {{name.pascalCase()}}View({super.key});

  @override
  Widget build(BuildContext context) {
{{#is_bloc}}{{> bloc_builder }}{{/is_bloc}}{{^is_bloc}}{{> cubit_bloc_builder }}{{/is_bloc}}
  }
}
