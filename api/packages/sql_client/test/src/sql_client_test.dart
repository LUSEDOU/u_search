// ignore_for_file: prefer_const_constructors
import 'package:sql_client/sql_client.dart';
import 'package:test/test.dart';

void main() {
  group('SqlClient', () {
    test('can be instantiated', () {
      expect(SqlClient(), isNotNull);
    });
  });
}
