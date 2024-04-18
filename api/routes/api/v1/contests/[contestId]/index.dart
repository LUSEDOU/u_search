import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:u_search_api/api.dart';

FutureOr<Response> onRequest(RequestContext context, int contestId) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getContest(context, contestId);
    // case HttpMethod.post:
      // return _createApply(context, contestId);
    case _:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

FutureOr<Response> _getContest(RequestContext context, int contestId) async {
  final dataSource = context.read<DataSource>();
  final contest = await dataSource.getContest(contestId);

  if (contest == null) {
    return Response(statusCode: HttpStatus.notFound);
  }

  return Response.json(body: contest);
}

// FutureOr<Response> _createApply(RequestContext context, int contestId) async {
//   final body = await context.request.json() as Map<String, dynamic>;
//   final contestId = body['contestId'];
//   final researchId = body['researchId'];
//
//   if (contestId is! int || researchId is! int) {
//     return Response(statusCode: HttpStatus.badRequest);
//   }
//
//   final dataSource = context.read<DataSource>();
//   final contest = await dataSource.getContest(contestId);
//   final research = await dataSource.getResearch(researchId);
//
//   if (contest == null || research == null) {
//     return Response(statusCode: HttpStatus.notFound);
//   }
//
//   final applies = await dataSource.getApplications();
//
//   final contest = Apply(
//     contest: contest,
//     research: research,
//     contestId: applies.length,
//   );
//
//   await dataSource.addApplication(contest);
//
//   return Response.json(body: contest);
// }
