import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:email_service/email_service.dart';
import 'package:u_search_api/api.dart';
import 'package:url_provider/url_provider.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    return _subscribe(context);
  }

  return Response.json(statusCode: HttpStatus.methodNotAllowed);
}

FutureOr<Response> _subscribe(RequestContext context) async {
  final json = await context.request.json() as Map<String, dynamic>;
  final email = json['email'];

  if (email is! String) {
    return Response.json(statusCode: HttpStatus.badRequest);
  }

  // finish in usil.pe usil.edu.pe usil.epg.edu.pe
  final regExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@(usil\.pe|usil\.edu\.pe|epg\.usil\.pe)$',
  );

  if (!regExp.hasMatch(email)) return Response.json();

  // checks if the user is already subscribed
  final user = context.read<User>();

  if (!user.isAnonymous) {
    final body = SubscribeResponse(
      success: true,
      user: user,
    );
    return Response.json(body: body);
  }

  // send email to user
  final emailService = context.read<EmailService>();
  final to = emailService.admins.first;
  final sended = await context.read<EmailService>().sendMailFromTemplate(
        to: to,
        parser: SubscribeMailParser(
          email: email,
          link: context
              .read<UrlProvider>()
              .webLink('users/new?email=$email'),
        ),
      );

  final body = SubscribeResponse(success: sended);

  return Response.json(body: body);
}
