import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:u_search_api/api.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _geContests(context);
    case _:
      return Response.json(statusCode: HttpStatus.methodNotAllowed);
  }
}

FutureOr<Response> _geContests(RequestContext context) async {
  final dataSource = context.read<DataSource>();
  final contests = await dataSource.getContests();
  return Response.json(
    body: ContestResponse(contests: contests),
  );
}
