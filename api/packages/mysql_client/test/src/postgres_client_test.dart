// ignore_for_file: prefer_const_constructors
import 'package:mocktail/mocktail.dart';
import 'package:mysql/mysql.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:test/test.dart';

class MockConnection extends Mock implements Connection {}

void main() {
  group('PostgresClient', () {
    late Connection connection;

    setUp(() {
      connection = MockConnection();
    });
  });

  group('HelHelper.per', () {
    group('upsertStatement', () {
      late String table;
      late Map<String, dynamic> values;

      setUp(() {
        table = 'table';
        values = {
          'bool': true,
          'int': 1,
          'string': 'value',
          'double': 1.0,
          'date': DateTime.now(),
          'map': {'key': 'value'},
        };
      });

      test('could parse every type of value', () {
        expect(() => Helper.upsertStatement(table, values), returnsNormally);
      });

      test('return a valid upsert statement', () {
        final statement = Helper.upsertStatement(table, values);
        expect(statement, contains('INSERT INTO $table'));
        expect(statement, contains('VALUES'));
      });

      test('return a valid upsert statement with conflict column', () {
        final statement = Helper.upsertStatement(table, values);
        expect(statement, contains('ON CONFLICT (id)'));
      });

      test('return a valid upsert statement with return column', () {
        final statement = Helper.upsertStatement(table, values);
        expect(statement, contains('RETURNING id'));
      });

      test('return a DO UPDATE SET for every column except returned column',
          () {
        final statement = Helper.upsertStatement(table, values);
        expect(statement, contains('DO UPDATE SET'));
        expect(statement, contains('bool = EXCLUDED.bool'));
        expect(statement, contains('int = EXCLUDED.int'));
        expect(statement, contains('string = EXCLUDED.string'));
        expect(statement, contains('double = EXCLUDED.double'));
        expect(statement, contains('date = EXCLUDED.date'));
        expect(statement, contains('map = EXCLUDED.map'));
      });
    });

    group('parseValue', () {
      test('return a parsed string value', () {
        expect(Helper.parseValue('value'), '"value"');
      });

      test('return a parsed int value', () {
        expect(Helper.parseValue(1), 1);
      });

      test('return a parsed double value', () {
        expect(Helper.parseValue(1.0), 1.0);
      });

      test('return a parsed bool value', () {
        expect(Helper.parseValue(true), true);
      });

      test('return a parsed DateTime value', () {
        final date = DateTime.now();
        expect(Helper.parseValue(date), "'${date.toIso8601String()}'");
      });

      test('return a parsed Map value', () {
        final map = {'key': 'value'};
        expect(Helper.parseValue(map), '{"key":"value"}');
      });
    });
  });
}
