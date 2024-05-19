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
    print('Mail read');

    final hasLink = template.contains('{{loginLink}}');
    assert(hasLink, 'The template does not contain the login link');
    final _$ = template.replaceAll('{{loginLink}}', link);
    assert(_$.contains(link), 'The link was not replaced');

    final hasUserName = template.contains('{{userName}}');
    assert(hasUserName, 'The template does not contain the user name');
    final $ = _$.replaceAll('{{userName}}', userName);
    assert($.contains(userName), 'The user name was not replaced');

    print('Mail parsed: ${$}');
    return $;
  }
}
