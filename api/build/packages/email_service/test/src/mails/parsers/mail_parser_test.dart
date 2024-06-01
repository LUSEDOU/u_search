//ignore_for_file: prefer_const_constructors
import 'package:email_service/email_service.dart';
import 'package:test/test.dart';

void main() {
  group('MailParser', () {
    test('should parse the mail template with the given data', () {
      // Arrange
      final mailParser = MailParser(
        subject: 'Solicitud de suscripción',
        template: 'subscribe',
        toAdmins: true,
      );
      // Act
      final result = mailParser.parseMail();
      // Assert
      expect(result, isA<String>());
    });
  });
}
