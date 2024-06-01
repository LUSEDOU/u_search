import 'package:dart_frog/dart_frog.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart' as shelf;

Middleware corsHeaders() {
  return fromShelfMiddleware(
    shelf.corsHeaders(
      headers: {
        shelf.ACCESS_CONTROL_ALLOW_ORIGIN: '*',
        shelf.ACCESS_CONTROL_ALLOW_METHODS: 'GET, POST, PUT, DELETE, OPTIONS',
        shelf.ACCESS_CONTROL_ALLOW_HEADERS:
            'Content-Type,X-Amz-Date,Authorization,X-Api-Key,'
                'X-Amz-Security-Token',
      },
    ),
  );
}
