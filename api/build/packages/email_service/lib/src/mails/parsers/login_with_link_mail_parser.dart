import 'package:email_service/email_service.dart';

/// {@template login_with_link_mail_parser}
/// A mail parser for the application reviewed mail.
/// {@endtemplate}
class LoginWithLinkMailParser extends MailParser {
  /// {@macro login_with_link_mail_parser}
  const LoginWithLinkMailParser({
    required this.link,
    required this.userName,
  }) : super(
          toAdmins: true,
          template: 'login_with_link',
          subject: 'USIL Proyectos - Inicio de sesión con enlace',
        );

  /// The link to login.
  final String link;

  /// The user name.
  final String userName;

  @override
  Future<String> parseMail() async {
    final template = await readTemplate();
    return template
        .replaceAll('{{loginLink}}', link)
        .replaceAll('{{userName}}', userName);
  }
}
