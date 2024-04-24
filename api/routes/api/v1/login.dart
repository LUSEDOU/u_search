import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:logging/logging.dart';
import 'package:u_search_api/api.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    return _logIn(context);
  }

  return Response.json(statusCode: HttpStatus.methodNotAllowed);
}

FutureOr<Response> _logIn(RequestContext context) async {
  final json = await context.request.json() as Map<String, dynamic>;
  final token = json['token'];
  Logger('login').info('token: $token');

  if (token is! String || token.isEmpty) {
    return Response.json(statusCode: HttpStatus.badRequest);
  }

  // checks if the user is already subscribed
  final dataSource = context.read<DataSource>();
  final email = await dataSource.getEmailToken(token);
  Logger('login').info('email: $email');
  if (email == null) {
    return Response.json(statusCode: HttpStatus.unauthorized);
  }

  final user = await dataSource.getUserByEmail(email);
  Logger('login').info('user: $user');

  if (user == null) {
    return Response.json(statusCode: HttpStatus.unauthorized);
  }

  final newToken = await dataSource.generateToken(user.id);

  return Response.json(
    body: LoginResponse(
      user: user,
      token: newToken,
    ),
  );
}
