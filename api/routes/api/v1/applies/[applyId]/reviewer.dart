import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:email_service/email_service.dart';
import 'package:u_search_api/api.dart';

FutureOr<Response> onRequest(RequestContext context, String applyId) async {
  switch (context.request.method) {
    case HttpMethod.post:
      final id = int.tryParse(applyId);
      if (id == null) return Response.json(statusCode: HttpStatus.badRequest);
      return _selectReviewer(context, id);
    // case HttpMethod.post:
    // return _createApply(context, id);
    case _:
      return Response.json(statusCode: HttpStatus.methodNotAllowed);
  }
}

FutureOr<Response> _selectReviewer(RequestContext context, int applyId) async {
  final dataSource = context.read<DataSource>();
  final apply = await dataSource.getApplicationRaw(applyId);
  final body = await context.request.json() as Map<String, dynamic>;
  final reviewerId = body['reviewerId'];

  if (reviewerId is! int || apply == null) {
    return Response.json(statusCode: HttpStatus.badRequest);
  }

  final reviewer = await dataSource.getUser(reviewerId);

  if (reviewer == null || reviewer.role != Role.reviewer) {
    return Response.json(statusCode: HttpStatus.notFound);
  }

  final updated = apply.copyWith(reviewer: reviewer.id);
  await dataSource.updateApplication(updated);

  await context.read<EmailService>().sendMailFromTemplate(
        to: reviewer.email,
        parser: ReviewerAssignedMailParser(
          reviewer: reviewer,
          application: apply,
          link: 'localhost:8080/applications/${apply.id}',
        ),
      );

  return Response.json(body: updated);
}

// FutureOr<Response> _createApply(RequestContext context, int id) async {
//   final body = await context.request.json() as Map<String, dynamic>;
//   final contestId = body['contestId'];
//   final researchId = body['researchId'];
//
//   if (contestId is! int || researchId is! int) {
//     return Response.json(statusCode: HttpStatus.badRequest);
//   }
//
//   final dataSource = context.read<DataSource>();
//   final contest = await dataSource.getContest(contestId);
//   final research = await dataSource.getResearch(researchId);
//
//   if (contest == null || research == null) {
//     return Response.json(statusCode: HttpStatus.notFound);
//   }
//
//   final applies = await dataSource.getApplications();
//
//   final apply = Apply(
//     contest: contest,
//     research: research,
//     id: applies.length,
//   );
//
//   await dataSource.addApplication(apply);
//
//   return Response.json(body: apply);
// }
