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
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

FutureOr<Response> _getApplies(RequestContext context) async {
  final dataSource = context.read<DataSource>();
  final applications = await dataSource.getApplications();
  return Response.json(
    body: ApplicationsResponse(applications: applications),
  );
}

FutureOr<Response> _createApply(RequestContext context) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final contestId = body['contestId'];
  final researchId = body['researchId'];

  if (contestId is! int || researchId is! int) {
    return Response(statusCode: HttpStatus.badRequest);
  }

  final dataSource = context.read<DataSource>();
  final contest = await dataSource.getContest(contestId);
  final research = await dataSource.getResearch(researchId);

  if (contest == null || research == null) {
    return Response(statusCode: HttpStatus.notFound);
  }

  final applies = await dataSource.getApplications();

  final apply = Apply(
    contest: contest,
    research: research,
    id: applies.length,
  );

  await dataSource.addApplication(apply);

  return Response.json(body: apply);
}
