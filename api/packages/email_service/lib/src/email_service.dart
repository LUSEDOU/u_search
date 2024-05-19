import 'dart:async';

import 'package:email_service/email_service.dart';
import 'package:logging/logging.dart';

/// {@template email_service}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class EmailService {
  /// {@macro email_service}
  const EmailService({
    required SmtpServer smtp,
    this.admins = const [],
    Logger? logger,
  })  : _smtp = smtp,
        _logger = logger;

  final SmtpServer _smtp;

  /// List of admin emails.
  final List<String> admins;

  /// Logger function.
  final Logger? _logger;

  Future<void> _sendMail({
    required String from,
    required String username,
    required String to,
    required String subject,
    required String mailBody,
    List<String> cc = const [],
  }) async {
    final message = Message()
      ..from = Address(from, username)
      ..recipients.add(to)
      ..ccRecipients.addAll(cc.map(Address.new))
      ..subject = subject
      ..html = mailBody;
    try {
      final report = await send(message, _smtp);
      _logger?.info(report);
    } catch (error, stackTrace) {
      _logger?.warning('Error sending mail: $error', error, stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  /// Sends a mail.
  FutureOr<bool> sendMail({
    required String to,
    required String subject,
    required String mailBody,
    bool ccAdmins = false,
  }) async {
    final username = _smtp.username;
    if (username == null) return false;

    try {
      await _sendMail(
        from: username,
        username: 'USIL Proyectos',
        to: to,
        subject: subject,
        mailBody: mailBody,
        cc: ccAdmins ? admins : [],
      );

      return true;
    } catch (_) {
      return false;
    }
  }

  /// Sends a mail from a template.
  FutureOr<bool> sendMailFromTemplate({
    required String to,
    required MailParser parser,
  }) async {
    final template = await parser.parseMail();

    return sendMail(
      to: to,
      subject: parser.subject,
      mailBody: template,
      ccAdmins: parser.toAdmins,
    );
  }
}
