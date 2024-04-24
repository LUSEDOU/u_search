import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:u_search_api/api.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getApplies(context);
    case HttpMethod.post:
      return _createApply(context);
    case _:
      return Response.json(statusCode: HttpStatus.methodNotAllowed);
  }
}

FutureOr<Response> _getApplies(RequestContext context) async {
  final user = context.read<User>();
  if (user.role == Role.none) {
    return Response.json(statusCode: HttpStatus.forbidden);
  }

  final dataSource = context.read<DataSource>();
  final applications = switch (user.role) {
    Role.researcher => await dataSource.getApplications(researcherId: user.id),
    Role.reviewer => await dataSource.getApplications(reviewerId: user.id),
    _ => await dataSource.getApplications(),
  };

  return Response.json(
    body: ApplicationsResponse(applications: applications),
  );
}

FutureOr<Response> _createApply(RequestContext context) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final contestId = body['contestId'];
  final researchId = body['researchId'];

  if (contestId is! int || researchId is! int) {
    return Response.json(statusCode: HttpStatus.badRequest);
  }

  final dataSource = context.read<DataSource>();

  final application = Application(
    contest: contestId,
    research: researchId,
  );
  await dataSource.addApplication(application);

  final apply = await dataSource.getApplication(application.id);

  if (apply == null) {
    return Response.json(statusCode: HttpStatus.internalServerError);
  }

  return Response.json(body: apply);
}
