import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:u_search_api/api.dart';

FutureOr<Response> onRequest(RequestContext context, String userId) async {
  switch (context.request.method) {
    case HttpMethod.get:
      switch (userId) {
        case 'reviewers':
          return _getReviewers(context);
        default:
          final id = int.tryParse(userId);
          if (id == null) {
            return Response.json(statusCode: HttpStatus.badRequest);
          }
          return _getUser(context, id);
      }
    case HttpMethod.post:
      final id = int.tryParse(userId);
      if (id == null) {
        return Response.json(statusCode: HttpStatus.badRequest);
      }
      return _postUser(context, id);
    case _:
      return Response.json(statusCode: HttpStatus.methodNotAllowed);
  }
}

FutureOr<Response> _getReviewers(RequestContext context) async {
  final dataSource = context.read<DataSource>();
  final users = await dataSource.getUsers(role: Role.reviewer.value);

  return Response.json(
    body: UsersResponse(users: users),
  );
}

FutureOr<Response> _getUser(RequestContext context, int id) async {
  final dataSource = context.read<DataSource>();
  final user = await dataSource.getUser(id);
  if (user == null) {
    return Response.json(statusCode: HttpStatus.notFound);
  }

  return Response.json(body: user);
}

FutureOr<Response> _postUser(RequestContext context, int id) async {
  final dataSource = context.read<DataSource>();

  final body = await context.request.json() as Map<String, dynamic>;
  try {
    await dataSource.updateUser(User.fromJson(body));
    return Response();
  } catch (e) {
    return Response.json(statusCode: HttpStatus.badRequest);
  }
}
