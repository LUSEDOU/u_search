import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';
import 'package:email_service/email_service.dart';
import 'package:logging/logging.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:u_search_api/api.dart';
import 'package:u_search_api/src/data/in_memory_data_source.dart';

late DataSource dataSource;
late EmailService emailService;
late Config config;

class Config {
  const Config({
    required this.smtpHost,
    required this.smtpUsername,
    required this.smtpPassword,
    bool? debug,
    this.admins = const [],
  }) : debug = debug ?? false;

  factory Config.fromEnv() {
    final env = DotEnv(includePlatformEnvironment: true)..load();
    return Config(
      smtpHost: env['SMTP_HOST'] ?? '',
      smtpUsername: env['SMTP_USERNAME'] ?? '',
      smtpPassword: env['SMTP_PASSWORD'] ?? '',
      admins: (env['ADMINS'] ?? '').split(','),
      debug: bool.tryParse(env['DEBUG'] ?? ''),
    );
  }

  final String smtpHost;
  final String smtpUsername;
  final String smtpPassword;
  final List<String> admins;
  final bool debug;
}

Future<void> init(InternetAddress ip, int port) async {
  // Any code initialized within this method will only run on server start,
  // any hot reloads
  // afterwards will not trigger this method until a hot restart.

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print(
      '${record.level.name} (${record.loggerName}): '
      '${record.time}: ${record.message}',
    );
  });

  config = Config.fromEnv();

  emailService = (config.debug ? EmailService.new : EmailServiceDev.new)(
    smtp: SmtpServer(
      config.smtpHost,
      username: config.smtpUsername,
      password: config.smtpPassword,
    ),
    admins: config.admins,
    logger: Logger('EmailService'),
  );

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  dataSource = await InMemoryDataSource.create(
    '${Directory.current.path}\\db.sqlite',
    logger: Logger('DataSource'),
  );

  return serve(
    handler,
    ip,
    port,
  );
}
