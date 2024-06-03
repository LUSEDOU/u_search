// ignore_for_file: prefer_const_constructors
import 'package:sqlite_client/sqlite_client.dart';
import 'package:test/test.dart';

void main() {
  group('SqliteClient', () {
    test('can be instantiated', () {
      expect(SqliteClient(), isNotNull);
    });
  });
}
