import 'dart:io';
import 'package:path/path.dart' as path;

/// {@template mail_sender}
/// An exception thrown when sending mail fails.
/// {@endtemplate}
class MailFailure implements Exception {
  /// {@macro mail_failure}
  const MailFailure(this.error);

  /// The error catched.
  final Object error;
}

/// {@template mail_parser_failure}
/// An exception thrown when parsing mail fails.
/// {@endtemplate}
class MailParserFailure extends MailFailure {
  /// {@macro mail_parser_failure}
  const MailParserFailure(super.error);
}

/// {@template mail_read_template_failure}
/// An exception thrown when reading the mail template fails.
/// {@endtemplate}
class MailReadTemplateFailure extends MailFailure {
  /// {@macro mail_read_template_failure}
  const MailReadTemplateFailure(super.error);
}

/// {@template mail_parser}
/// Abstract class for parsing mail templates.
/// {@endtemplate}
class MailParser {
  /// {@macro mail_parser}
  const MailParser({
    required this.subject,
    required this.template,
    this.toAdmins = false,
  });

  /// The name of the template file.
  final String template;

  /// The mail subject.
  final String subject;

  /// Whether to send the mail to the admins.
  final bool toAdmins;

  /// Parses the mail template with the given data.
  ///
  /// Throws a [MailParserFailure] if parsing fails.
  Future<String> parseMail() {
    return readTemplate();
  }

  /// Returns the template content.
  ///
  /// Throws a [MailReadTemplateFailure] if reading the template fails.
  Future<String> readTemplate() async {
    try {
      final template = path.join(
        path.current,
        'packages',
        'email_service',
        'lib',
        'src',
        'mails',
        'templates',
        '${this.template}.html',
      );

      return await File(template).readAsString();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(MailReadTemplateFailure(error), stackTrace);
    }
  }
}
