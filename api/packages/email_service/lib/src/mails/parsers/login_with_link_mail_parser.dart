import 'package:email_service/email_service.dart';

/// {@template login_with_link_mail_parser}
/// A mail parser for the application reviewed mail.
/// {@endtemplate}
class LoginWithLinkMailParser extends MailParser {
  /// {@macro login_with_link_mail_parser}
  const LoginWithLinkMailParser({
    required this.link,
  }) : super(
          toAdmins: true,
          template: 'login_with_link',
          subject: 'Login with Link',
        );

  /// The link to login.
  final String link;

  @override
  Future<String> parseMail() async {
    final template = await readTemplate();

    return template..replaceAll('{{loginLink}}', link);
  }
}
