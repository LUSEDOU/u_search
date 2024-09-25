import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:logging/logging.dart';
import 'package:u_search_api/api.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getUsers(context);
    case HttpMethod.post:
      return _postUser(context);
    case _:
      return Response.json(statusCode: HttpStatus.methodNotAllowed);
  }
}

FutureOr<Response> _getUsers(RequestContext context) async {
  final dataSource = context.read<DataSource>();
  final users = await dataSource.getUsers();

  return Response.json(
    body: UsersResponse(users: users),
  );
}

FutureOr<Response> _postUser(RequestContext context) async {
  final body = await context.request.json() as Map<String, dynamic>;
  context.read<Logger>().info('Received body: $body');
  final dataSource = context.read<DataSource>();

  try {
    final user = User.fromJson(body);

    final newUser = await dataSource.createUser(user);
    return Response.json(body: newUser);
  } catch (e) {
    context.read<Logger>().severe('Error creating user: $e');
    return Response.json(statusCode: HttpStatus.badRequest);
  }
}
