import 'package:dart_frog/dart_frog.dart';
import 'package:logging/logging.dart';
import 'package:u_search_api/api.dart';
import '../headers/headers.dart';
import '../main.dart';

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger(logger: Logger('RequestLogger').info))
      .use(contentTypeHeader())
      .use(provider<DataSource>((_) => dataSource))
      .use(userProvider);
}
