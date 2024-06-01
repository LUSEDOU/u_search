import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:u_search_api/api.dart';
import 'package:uuid/uuid.dart';

FutureOr<Response> onRequest(RequestContext context, String reseachId) async {
  switch (context.request.method) {
    case HttpMethod.get:
      final id = int.tryParse(reseachId);
      if (id == null) {
        return Response.json(statusCode: HttpStatus.badRequest);
      }
      return _getResearchFile(context, id);
    case _:
      return Response.json(statusCode: HttpStatus.methodNotAllowed);
  }
}

FutureOr<Response> _getResearchFile(RequestContext context, int id) async {
  final dataSource = context.read<DataSource>();

  final research = await dataSource.getResearch(id);
  if (research == null) {
    return Response.json(statusCode: HttpStatus.notFound);
  }

  final filePath = path.join(
    path.current,
    'public',
    'researches',
    '${research.uuid}.pdf',
  );

  final file = File(filePath);
  if (!file.existsSync()) {
    return Response.json(statusCode: HttpStatus.notFound);
  }

  final bytes = await file.readAsBytes();
  final base64 = base64Encode(bytes);

  return Response.json(body: {'base64': base64});
}
