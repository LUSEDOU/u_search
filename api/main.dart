import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:logging/logging.dart';
import 'package:u_search_api/api.dart';
import 'package:u_search_api/src/data/in_memory_data_source.dart';

late DataSource dataSource;

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  dataSource = InMemoryDataSource();

  return serve(
    handler,
    ip,
    port,
  );
}
