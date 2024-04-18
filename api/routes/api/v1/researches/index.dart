import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:u_search_api/api.dart';
import 'package:uuid/uuid.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.post:
      return _createResearch(context);
    case _:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

FutureOr<Response> _createResearch(RequestContext context) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final encodedFile = body['file'];
  final title = body['title'];

  if (encodedFile is! String || title is! String) {
    return Response(statusCode: HttpStatus.badRequest);
  }

  final dataSource = context.read<DataSource>();

  final temDir = await getTemporaryDirectory();
  final uuid = const Uuid().v4();
  final file = File('${temDir.path}/$uuid');
  await file.writeAsBytes(base64Decode(encodedFile));

  final contests = await dataSource.getContests();

  final research = Research(
    uuid: uuid,
    title: title,
    length: await file.length(),
    researcher: context.read<User>().id,
    id: contests.length,
  );

  // save the file in the www/u_search/api/public/researches directory
  Logger.root
    ..info(path.current)
    ..info(
      path.join(
        path.current,
        'www',
        'u_search',
        'api',
        'public',
        'researches',
        research.uuid,
      ),
    );

  await dataSource.addResearch(research);

  return Response.json(body: research);
}
