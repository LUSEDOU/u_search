import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
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

  final user = await _getUser(context, email: email);

  if (user == null) return Response();

  // send email to user
  // final sended = context.read<EmailService>().sendLoginEmailLink(
  //       email: email,
  //       token: token,
  //     );
  await Future(() => true);
  return Response();
}

Future<User?> _getUser(RequestContext context, {required String email}) async {
  return User.anonymous;
}
