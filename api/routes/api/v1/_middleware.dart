import 'package:dart_frog/dart_frog.dart';

import '../../headers/headers.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(contentTypeHeader());
}
