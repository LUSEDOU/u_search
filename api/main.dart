import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';
import 'package:email_service/email_service.dart';
import 'package:logging/logging.dart';
import 'package:u_search_api/api.dart';
import 'package:u_search_api/src/data/in_memory_data_source.dart';

late DataSource dataSource;
late EmailService emailService;

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print(
      '${record.level.name} (${record.loggerName}): '
      '${record.time}: ${record.message}',
    );
  });
  final env = DotEnv(includePlatformEnvironment: true)..load();

  dataSource = InMemoryDataSource();
  final userName = env['SMTP_USERNAME'] ?? '';
  final password = env['SMTP_PASSWORD'] ?? '';
  final admins = (env['ADMINS'] ?? '').split(',');
  Logger('main').info('Admins: $admins');

  emailService = EmailService(
    smtp: SmtpServer(
      'smtp-mail.outlook.com',
      username: userName,
      password: password,
    ),
    admins: admins,
    // logger: (message, {required success}) => Logger('EmailService')
    //     .info('${message.from} ${message.headers} ${message.recipients}'),
  );

  return serve(
    handler,
    ip,
    port,
  );
}
