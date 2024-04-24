import 'package:dart_frog/dart_frog.dart';
import 'package:logging/logging.dart';

Middleware logMiddleware() {
  return (handler) {
    return (context) async {
      final request = context.request;
      final method = request.method;
      final path = request.uri.path;
      final message = '$method $path';
      Logger('Request').info('Received: $message Header: ${request.headers}');

      final response = await handler(context);
      return response;
    };
  };
}
