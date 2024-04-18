// ignore_for_file: prefer_const_constructors
import 'package:email_service/email_service.dart';
import 'package:test/test.dart';

void main() {
  group('EmailService', () {
    test('can be instantiated', () {
      expect(EmailService(), isNotNull);
    });
  });
}
