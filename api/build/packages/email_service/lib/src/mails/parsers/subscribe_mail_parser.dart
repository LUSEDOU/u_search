import 'package:email_service/email_service.dart';

/// {@template application_reviewed_mail_parser}
/// A mail parser for the application reviewed mail.
/// {@endtemplate}
class SubscribeMailParser extends MailParser {
  /// {@macro application_reviewed_mail_parser}
  const SubscribeMailParser({
    required this.email,
    required this.link,
  }) : super(
          toAdmins: true,
          template: 'subscribe',
          subject: 'Solicitud de suscripción',
        );

  /// The email of the user.
  final String email;

  /// The link to the review.
  final String link;

  @override
  Future<String> parseMail() async {
    final template = await readTemplate();

    return template.replaceAll('{{email}}', email).replaceAll('{{link}}', link);
  }
}
