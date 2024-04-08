import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:u_search_api/api.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    return _subscribe(context);
  }

  return Response(statusCode: HttpStatus.methodNotAllowed);
}

FutureOr<Response> _subscribe(RequestContext context) async {
  final json = await context.request.json() as Map<String, dynamic>;
  final email = json['email'];

  if (email is! String) {
    return Response(statusCode: HttpStatus.badRequest);
  }

  // finish in usil.pe usil.edu.pe usil.epg.edu.pe
  final regExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@(usil\.pe|usil\.edu\.pe|epg\.usil\.pe)$',
  );

  if (!regExp.hasMatch(email)) return Response();

  // checks if the user is already subscribed
  final user = await _getUser(context, email: email);

  if (user != null) {
    final body = SubscribeResponse(
      success: true,
      user: user,
    );
    return Response.json(body: body);
  }

  // send email to user
  // final sended = await _sendEmail(email);
  final sended = await Future(() => true);

  final body = SubscribeResponse(success: sended);

  return Response.json(body: body);
}

Future<User?> _getUser(RequestContext context, {required String email}) async {
  return null;
}
