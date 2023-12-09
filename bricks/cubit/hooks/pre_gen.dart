import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final repository = context.vars['repository'];
  print('repository: $repository');
  context.vars = {
    ...context.vars,
    'use_repository': repository.isNotEmpty,
    'not_use_repository': repository.isEmpty,
  };
}
