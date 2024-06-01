import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:u_search_api/api.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getReviewers(context);
    case _:
      return Response.json(statusCode: HttpStatus.methodNotAllowed);
  }
}

FutureOr<Response> _getReviewers(RequestContext context) async {
  final dataSource = context.read<DataSource>();
  final reviewers = await dataSource.getUsers(role: Role.reviewer.value);

  return Response.json(
    body: ReviewerResponse(reviewers: reviewers),
  );
}
