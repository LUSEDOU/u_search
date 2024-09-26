import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:email_service/email_service.dart';
import 'package:logging/logging.dart';
import 'package:u_search_api/api.dart';
import 'package:url_provider/url_provider.dart';


FutureOr<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    return _auth(context);
  }

  return Response.json(statusCode: HttpStatus.methodNotAllowed);
}

FutureOr<Response> _auth(RequestContext context) async {
  final logger = Logger('auth');

  final json = await context.request.json() as Map<String, dynamic>;
  logger.info(json);
  final email = json['email'];

  if (email is! String) {
    return Response.json(statusCode: HttpStatus.badRequest);
  }

  final regExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@(usil\.pe|usil\.edu\.pe|epg\.usil\.pe)$',
  );

  if (!regExp.hasMatch(email)) {
    logger.info('not match $email');
    return Response.json();
  }
  logger.info('match');

  if (!context.read<User>().isAnonymous) return Response.json();

  final dataSource = context.read<DataSource>();
  final user = await dataSource.getUserByEmail(email);
  logger.info(user?.toJson());
  if (user == null) return Response.json();

  final token = await dataSource.generateEmailToken(email);
  logger.info(token);
  await context.read<EmailService>().sendMailFromTemplate(
        to: email,
        parser: LoginWithLinkMailParser(
          link: context.read<UrlProvider>().webLink('login?token=$token'),
          userName: user.name,
        ),
      );

  return Response.json();
}
