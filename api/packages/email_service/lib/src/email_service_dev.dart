import 'dart:async';

import 'package:email_service/email_service.dart';
import 'package:logging/logging.dart';

/// {@template email_service_dev}
/// A development version of the [EmailService] that does not send emails.
/// {@endtemplate}
class EmailServiceDev extends EmailService {
  /// {@macro email_service_dev}
  EmailServiceDev({
    required super.smtp,
    super.admins = const [],
    super.logger,
  })  : _logger = logger;

  final Logger? _logger;

  @override
  FutureOr<bool> sendMail({
    required String to,
    required String subject,
    required String mailBody,
    bool ccAdmins = false,
  }) async {
    _logger?.info('Sending mail {$subject} to $to');
    return true;
  }

  @override
  FutureOr<bool> sendMailFromTemplate({
    required String to,
    required MailParser parser,
  }) async {
    try {
      final mailBody = await parser.parseMail();
      return sendMail(
        to: to,
        subject: parser.subject,
        mailBody: mailBody,
      );
    } on MailFailure catch (e) {
      _logger?.warning('Error sending mail: $e');
      return false;
    }
  }
}
