import 'dart:html';

import 'package:dart_frog/dart_frog.dart';
import 'package:u_search_api/api.dart';

Middleware get userProvider => (handler) {
      return (context) async {
        final authorization =
            context.request.headers['authorization']?.split(' ');
        if (authorization != null &&
            authorization.length == 2 &&
            authorization.first == 'Bearer') {
          final token = authorization.last;

          final user = await _verifyToken(token, context);
          if (user != null) {
            return handler(context.provide(() => user));
          }
        }
        return Response(statusCode: HttpStatus.unauthorized);
      };
    };

Future<User?> _verifyToken(String token, RequestContext context) async {
  if (token case 'pe.edu.usil.usearch' || 'pe.edu.usil.usearch.dev') {
    return User.anonymous;
  }

  final dataSource = context.read<DataSource>();
  return dataSource.getUserByToken(token);
}
