import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:email_service/email_service.dart';
import 'package:logging/logging.dart';
import 'package:u_search_api/api.dart';

FutureOr<Response> onRequest(RequestContext context, String applyId) async {
  final id = int.tryParse(applyId);
  if (id == null) return Response.json(statusCode: HttpStatus.badRequest);
  switch (context.request.method) {
    case HttpMethod.get:
      return _getReview(context, id);
    case HttpMethod.post:
      return _createReview(context, id);
    case _:
      return Response.json(statusCode: HttpStatus.methodNotAllowed);
  }
}

FutureOr<Response> _getReview(RequestContext context, int applyId) async {
  final dataSource = context.read<DataSource>();
  final apply = await dataSource.getApplication(applyId);

  if (apply == null) {
    return Response.json(statusCode: HttpStatus.notFound);
  }

  final review = apply.review;
  if (review != null) {
    return Response.json(body: review);
  }

  final contest = apply.contest;
  final criterias = contest.criterias;
  Logger('getReview').info(criterias);

  const calification = Calification.empty;

  final emptyReview = Review(
    id: -1,
    calification: calification,
    criterias: criterias,
  );

  return Response.json(body: emptyReview);
}

FutureOr<Response> _createReview(RequestContext context, int applyId) async {
  final dataSource = context.read<DataSource>();
  final apply = await dataSource.getApplicationRaw(applyId);
  final researcher = await dataSource.getResearcherFromApply(applyId);

  if (apply == null || researcher == null) {
    return Response.json(statusCode: HttpStatus.notFound);
  }

  final body = await context.request.json() as Map<String, dynamic>;
  final review = Review.fromJson(body);

  final reviewId = await dataSource.addReview(review);

  final emailService = context.read<EmailService>();
  await emailService.sendMailFromTemplate(
    to: researcher.email,
    parser: ApplicationReviewedMailParser(
      application: apply,
      link: 'localhost:8080/applies/$applyId/review',
    ),
  );

  final updatedApply = apply.copyWith(review: reviewId);
  await dataSource.updateApplication(updatedApply);

  return Response.json(body: review.copyWith(id: reviewId));
}
