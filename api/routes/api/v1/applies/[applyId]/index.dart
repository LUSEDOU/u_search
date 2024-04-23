import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:u_search_api/api.dart';

FutureOr<Response> onRequest(RequestContext context, int applyId) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getApply(context, applyId);
    // case HttpMethod.post:
      // return _createApply(context, applyId);
    case _:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

FutureOr<Response> _getApply(RequestContext context, int applyId) async {
  final dataSource = context.read<DataSource>();
  final apply = await dataSource.getApplication(applyId);
  if (apply == null) {
    return Response(statusCode: HttpStatus.notFound);
  }
  return Response.json(body: apply);
}

// FutureOr<Response> _createApply(RequestContext context, int applyId) async {
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
//   final apply = Apply(
//     contest: contest,
//     research: research,
//     applyId: applies.length,
//   );
//
//   await dataSource.addApplication(apply);
//
//   return Response.json(body: apply);
// }