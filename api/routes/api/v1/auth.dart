import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:email_service/email_service.dart';
import 'package:u_search_api/api.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    return _auth(context);
  }

  return Response(statusCode: HttpStatus.methodNotAllowed);
}

FutureOr<Response> _auth(RequestContext context) async {
  final json = await context.request.json() as Map<String, dynamic>;
  final email = json['email'];

  if (email is! String) {
    return Response(statusCode: HttpStatus.badRequest);
  }

  final regExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@(usil\.pe|usil\.edu\.pe|epg\.usil\.pe)$',
  );

  if (!regExp.hasMatch(email)) return Response();

  if (!context.read<User>().isAnonymous) return Response();

  final dataSource = context.read<DataSource>();
  final user = await dataSource.getUserByEmail(email);
  if (user == null) return Response();

  final token = await dataSource.generateEmailToken(email);
  await context.read<EmailService>().sendMailFromTemplate(
        to: email,
        parser: LoginWithLinkMailParser(
          link: 'localhost:8080/login?token=$token',
        ),
      );
  return Response();
}
