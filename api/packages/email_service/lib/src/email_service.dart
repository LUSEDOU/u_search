import 'dart:async';

import 'package:email_service/email_service.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

typedef _Logger = void Function(Message message, {required bool success});

/// {@template email_service}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class EmailService {
  /// {@macro email_service}
  const EmailService({
    required SmtpServer smtp,
    this.admins = const [],
    this.logger,
  }) : _smtp = smtp;

  final SmtpServer _smtp;
  final List<String> admins;
  final _Logger? logger;

  Future<void> _sendMail({
    required String from,
    required String username,
    required String to,
    required String subject,
    required String mailBody,
    List<String> cc = const [],
  }) async {
    return;
    final message = Message()
      ..from = Address(from, username)
      ..recipients.add(to)
      ..ccRecipients.addAll(cc.map(Address.new))
      ..subject = subject
      ..text = mailBody;
    try {
      await send(message, _smtp);
      logger?.call(message, success: true);
    } catch (error, stackTrace) {
      logger?.call(message, success: false);
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
