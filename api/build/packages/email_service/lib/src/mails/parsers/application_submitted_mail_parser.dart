import 'package:app_domain/app_domain.dart';
import 'package:email_service/email_service.dart';

/// {@template application_submitted_mail_parser}
/// A mail parser for the application reviewed mail.
/// {@endtemplate}
class ApplicationSubmittedMailParser extends MailParser {
  /// {@macro application_submitted_mail_parser}
  const ApplicationSubmittedMailParser({
    required this.application,
    required this.link,
  }) : super(
          toAdmins: true,
          template: 'application_submitted',
          subject: 'Aplicación enviada',
        );

  /// The application to be reviewed.
  final Application application;

  /// The link to the review.
  final String link;

  @override
  Future<String> parseMail() async {
    final template = await readTemplate();

    return template
        .replaceAll('{{applicationId}', '${application.id}')
        .replaceAll('{{link}}', link);
  }
}
