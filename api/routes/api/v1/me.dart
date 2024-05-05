import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:u_search_api/api.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.get) {
    return _auth(context);
  }

  return Response.json(statusCode: HttpStatus.methodNotAllowed);
}

FutureOr<Response> _auth(RequestContext context) async {
  final user = context.read<User>();
  return Response.json(body: user);
}
