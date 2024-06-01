// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../main.dart' as entrypoint;
import '../routes/api/v1/subscribe.dart' as api_v1_subscribe;
import '../routes/api/v1/me.dart' as api_v1_me;
import '../routes/api/v1/login.dart' as api_v1_login;
import '../routes/api/v1/auth.dart' as api_v1_auth;
import '../routes/api/v1/users/reviewers.dart' as api_v1_users_reviewers;
import '../routes/api/v1/researches/index.dart' as api_v1_researches_index;
import '../routes/api/v1/researches/[reasearchId].dart' as api_v1_researches_$reasearch_id;
import '../routes/api/v1/contests/index.dart' as api_v1_contests_index;
import '../routes/api/v1/contests/[contestId]/index.dart' as api_v1_contests_$contest_id_index;
import '../routes/api/v1/applies/index.dart' as api_v1_applies_index;
import '../routes/api/v1/applies/[applyId]/reviewer.dart' as api_v1_applies_$apply_id_reviewer;
import '../routes/api/v1/applies/[applyId]/review.dart' as api_v1_applies_$apply_id_review;
import '../routes/api/v1/applies/[applyId]/index.dart' as api_v1_applies_$apply_id_index;

import '../routes/_middleware.dart' as middleware;

void main() async {
  final address = InternetAddress.anyIPv6;
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  createServer(address, port);
}

Future<HttpServer> createServer(InternetAddress address, int port) async {
  final handler = Cascade().add(createStaticFileHandler()).add(buildRootHandler()).handler;
  final server = await entrypoint.run(handler, address, port);
  print('\x1B[92m✓\x1B[0m Running on http://${server.address.host}:${server.port}');
  return server;
}

Handler buildRootHandler() {
  final pipeline = const Pipeline().addMiddleware(middleware.middleware);
  final router = Router()
    ..mount('/api/v1/applies/<applyId>', (context,applyId,) => buildApiV1Applies$applyIdHandler(applyId,)(context))
    ..mount('/api/v1/applies', (context) => buildApiV1AppliesHandler()(context))
    ..mount('/api/v1/contests/<contestId>', (context,contestId,) => buildApiV1Contests$contestIdHandler(contestId,)(context))
    ..mount('/api/v1/contests', (context) => buildApiV1ContestsHandler()(context))
    ..mount('/api/v1/researches', (context) => buildApiV1ResearchesHandler()(context))
    ..mount('/api/v1/users', (context) => buildApiV1UsersHandler()(context))
    ..mount('/api/v1', (context) => buildApiV1Handler()(context));
  return pipeline.addHandler(router);
}

Handler buildApiV1Applies$applyIdHandler(String applyId,) {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/reviewer', (context) => api_v1_applies_$apply_id_reviewer.onRequest(context,applyId,))..all('/review', (context) => api_v1_applies_$apply_id_review.onRequest(context,applyId,))..all('/', (context) => api_v1_applies_$apply_id_index.onRequest(context,applyId,));
  return pipeline.addHandler(router);
}

Handler buildApiV1AppliesHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => api_v1_applies_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildApiV1Contests$contestIdHandler(String contestId,) {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => api_v1_contests_$contest_id_index.onRequest(context,contestId,));
  return pipeline.addHandler(router);
}

Handler buildApiV1ContestsHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => api_v1_contests_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildApiV1ResearchesHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => api_v1_researches_index.onRequest(context,))..all('/<reasearchId>', (context,reasearchId,) => api_v1_researches_$reasearch_id.onRequest(context,reasearchId,));
  return pipeline.addHandler(router);
}

Handler buildApiV1UsersHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/reviewers', (context) => api_v1_users_reviewers.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildApiV1Handler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/subscribe', (context) => api_v1_subscribe.onRequest(context,))..all('/me', (context) => api_v1_me.onRequest(context,))..all('/login', (context) => api_v1_login.onRequest(context,))..all('/auth', (context) => api_v1_auth.onRequest(context,));
  return pipeline.addHandler(router);
}

