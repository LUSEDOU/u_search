import 'dart:async';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

/// {@template email_service}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class EmailService {
  /// {@macro email_service}
  const EmailService({
    required SmtpServer smtp,
    List<String> admins = const [],
  })  : _smtp = smtp,
        _admins = admins;

  final SmtpServer _smtp;
  final List<String> _admins;

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
      ..text = mailBody;

    await send(message, _smtp);
  }

  FutureOr<bool> sendMail({
    required String to,
    required String subject,
    required String mailBody,
    bool ccAdmins = false,
  }) async {
    final username = _smtp.username;
    if (username == null) return false;

    await _sendMail(
      from: username,
      username: 'USIL Proyectos',
      to: to,
      subject: subject,
      mailBody: mailBody,
      cc: ccAdmins ? _admins : [],
    );
  }
}
