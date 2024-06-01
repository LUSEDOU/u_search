import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:email_service/email_service.dart';
import 'package:logging/logging.dart';
import 'package:u_search_api/api.dart';
import 'package:url_provider/url_provider.dart';

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
  final contestId = body['contest'];
  final researchId = body['research'];

  if (contestId is! int || researchId is! int) {
    return Response.json(statusCode: HttpStatus.badRequest);
  }

  final dataSource = context.read<DataSource>();

  final applicationId = await dataSource.addApplication(
    Application(
      contest: contestId,
      research: researchId,
    ),
  );

  final apply = await dataSource.getApplication(applicationId);

  if (apply == null) {
    return Response.json(statusCode: HttpStatus.internalServerError);
  }

  context.read<EmailService>().sendMailFromTemplate(
        to: context.read<User>().email,
        parser: ApplicationSubmittedMailParser(
          application: apply.toApplication(),
          link:
              context.read<UrlProvider>().webLink('applies/${apply.id}'),
        ),
      );

  return Response.json(body: apply);
}
