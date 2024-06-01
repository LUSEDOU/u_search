import 'package:app_domain/app_domain.dart';
import 'package:email_service/email_service.dart';

/// {@template reviewer_assigned_mail_parser}
/// A mail parser for the application reviewed mail.
/// {@endtemplate}
class ReviewerAssignedMailParser extends MailParser {
  /// {@macro reviewer_assigned_mail_parser}
  const ReviewerAssignedMailParser({
    required this.reviewer,
    required this.application,
    required this.link,
  }) : super(
          toAdmins: true,
          template: 'reviewer_assigned',
          subject: 'Review Assigned',
        );

  /// The link to the review.
  final String link;

  /// The reviewer to assign the review.
  final User reviewer;

  /// The application to be reviewed.
  final Application application;

  @override
  Future<String> parseMail() async {
    final template = await readTemplate();

    return template
      .replaceAll('{{applicationId}', '${application.id}')
      .replaceAll('{{reviewer}}', reviewer.name)
      .replaceAll('{{link}}', link);
  }
}
