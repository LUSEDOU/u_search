import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../routes/v1/subscribe.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockRequest extends Mock implements Request {}

void main() {
  group('POST /subscribe', () {
    late Request request;
    late RequestContext context;

    setUp(() {
      request = _MockRequest();
      when(() => request.method).thenReturn(HttpMethod.post);
      when(request.json).thenAnswer((_) async => {'email': 'test@usil.pe'});

      context = _MockRequestContext();
      when(() => context.request).thenReturn(request);
    });

    test('responds with a 200', () async {
      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
    });

    test('responds with a 400 when request is invalid', () async {
      when(request.json).thenAnswer((_) async => {'email': 123});
      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.badRequest));
    });

    test('responds with success true and user null', () async {
      final response = await route.onRequest(context);
      expect(
        response.body(),
        completion(equals('{"success":true,"user":null}')),
      );
    });

    test('not allowed for other methods', () async {
      when(() => request.method).thenReturn(HttpMethod.get);
      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });
  });
}
