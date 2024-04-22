import 'package:app_domain/app_domain.dart';
import 'package:email_service/email_service.dart';

/// {@template application_reviewed_mail_parser}
/// A mail parser for the application reviewed mail.
/// {@endtemplate}
class ApplicationReviewedMailParser extends MailParser {
  /// {@macro application_reviewed_mail_parser}
  const ApplicationReviewedMailParser({
    required this.application,
    required this.link,
  }) : super(
          toAdmins: true,
          template: 'application_reviewed',
          subject: 'Se revisó la aplicación',
        );

  /// The application to be reviewed.
  final Application application;

  /// The link to the review.
  final String link;

  @override
  Future<String> parseMail() async {
    final template = await readTemplate();

    return template
      ..replaceAll('{{applicationId}', '${application.id}')
      ..replaceAll('{{link}}', link);
  }
}
