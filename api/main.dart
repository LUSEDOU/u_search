import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:email_service/email_service.dart';
import 'package:logging/logging.dart';
import 'package:u_search_api/api.dart';
import 'package:u_search_api/src/data/in_memory_data_source.dart';

late DataSource dataSource;
late EmailService emailService;

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print(
      '${record.level.name} (${record.loggerName}): '
      '${record.time}: ${record.message}',
    );
  });
  Logger.root.level = Level.ALL;
  dataSource = InMemoryDataSource();
  emailService = EmailService(
    smtp: gmail('noreplayusearch@gmail.com', 'Usil2018*'),
  );

  return serve(
    handler,
    ip,
    port,
  );
}
