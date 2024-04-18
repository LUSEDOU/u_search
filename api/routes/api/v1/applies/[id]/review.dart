import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:u_search_api/api.dart';

FutureOr<Response> onRequest(RequestContext context, int applyId) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getReview(context, applyId);
    case HttpMethod.post:
      return _createReview(context, applyId);
    case _:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

FutureOr<Response> _getReview(RequestContext context, int applyId) async {
  final dataSource = context.read<DataSource>();
  final apply = await dataSource.getApplication(applyId);

  if (apply == null) {
    return Response(statusCode: HttpStatus.notFound);
  }

  final review = apply.review;
  if (review != null) {
    return Response.json(body: review);
  }

  final emptyReview = Review(
    id: -1,
    califications: const [],
    criterias: apply.contest.criterias,
  );

  return Response.json(body: emptyReview);
}

FutureOr<Response> _createReview(RequestContext context, int applyId) async {
  final apply = await context.read<DataSource>().getApplication(applyId);

  if (apply == null) {
    return Response(statusCode: HttpStatus.notFound);
  }

  final body = await context.request.json() as Map<String, dynamic>;
  final review = Review.fromJson(body);

  final dataSource = context.read<DataSource>();
  await dataSource.addReview(review);

  // await context.read<EmailService>().sendReviewedEmail(
  //       reviewer: context.read<User>(),
  //       researcher: apply.research.researcher,
  //       apply: apply.id,
  //     );

  return Response.json(body: review);
}
