import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:mysql_client/mysql_client.dart';

/// {@template my_sql_client}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class MySqlClient {
  /// {@macro my_sql_client}
  const MySqlClient({
    required MySQLConnection connection,
    Logger? logger,
  })  : _connection = connection,
        _logger = logger;

  final MySQLConnection _connection;
  final Logger? _logger;

  /// Closes the connection to the database.
  Future<void> close() async {
    _logger?.info('Closing connection');
    await _connection.close();
  }

  /// Upserts a record into the given [table] with the given [value].
  /// And returns the id of the upserted record.
  Future<int> upsert(
    String table,
    Map<String, dynamic> value,
  ) async {
    final statement = Helper.upsertStatement(
      table,
      value,
    );
    _logger?.info('Upserting: $statement');

    final result = await _connection.execute(statement);
    _logger?.info('Upserted: $result');

    final resultSets = await _connection.execute('SELECT LAST_INSERT_ID()');
    final map = resultSets.rows.first.typedAssoc();
    final id = map['LAST_INSERT_ID()'] as int;
    return id;
  }

  /// Selects records from the given [table] with the given [where] clause.
  /// Optionally, the results can be ordered by [orderBy], limited by [limit],
  /// and offset by [offset].
  Future<List<Map<String, dynamic>>> select(
    String table, {
    String? where,
    String? join,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final statement = Helper.selectStatement(
      table,
      where: where,
      orderBy: orderBy,
      join: join,
      limit: limit,
      offset: offset,
    );
    _logger?.info('Selecting: $statement');

    final result = await _connection.execute(statement);
    final rows = result.rows.map(
      (row) {
        final map = row.typedAssoc();
        // if any String value contains a {, then it is a json string
        map.forEach((key, value) {
          if (value is String && value.contains('{')) {
            map[key] = jsonDecode(value);
          }
        });
        return map;
      },
    ).toList();

    _logger?.info('Selected: $rows');
    return rows;
  }

  /// Selects a single record from the given [table] with the given
  /// [where] clause.
  Future<Map<String, dynamic>?> selectOne(
    String table, {
    required String where,
    String? orderBy,
  }) async {
    final result = await select(
      table,
      where: where,
      orderBy: orderBy,
      limit: 1,
    );

    return result.isNotEmpty ? result.first : null;
  }
}

class Helper {
  static dynamic parseValue(dynamic value) {
    switch (value.runtimeType) {
      case String:
        return '"$value"';
      case int || double || bool:
        return value;
      case DateTime:
        final date = value as DateTime;
        return "'${date.toIso8601String()}'";
      default:
        if (value is Map<String, dynamic>) {
          return jsonEncode(value);
        }
        throw Exception('Unsupported type: ${value.runtimeType}');
    }
  }

  /// Generates an upsert statement for the given [table] and [value].
  ///
  /// ```sql
  /// INSERT IGNORE INTO table (column1, column2)
  /// VALUES (value1, value2);
  /// ```
  static String upsertStatement(
    String table,
    Map<String, dynamic> value,
  ) {
    final columns = value.keys.join(', ');
    final values = value.values.map(parseValue).join(', ');

    final writer = StringBuffer('INSERT IGNORE INTO $table ($columns) \n')
      ..write('VALUES ($values);');

    return writer.toString();
  }

  /// Generates a select statement for the given [table].
  ///
  /// ```sql
  /// SELECT t.* FROM table t
  /// WHERE column = value
  /// JOIN join ON t.column = join.column
  /// ORDER BY t.column
  /// LIMIT 1
  /// OFFSET 0;
  /// ```
  static String selectStatement(
    String table, {
    String select = 't.*',
    String? join,
    String? where,
    String? orderBy,
    int? limit,
    int? offset,
  }) {
    final writer = StringBuffer('SELECT $select FROM $table t ');

    if (where != null) writer.write('\nWHERE $where ');
    if (join != null) writer.write('\n$join ');
    if (orderBy != null) writer.write('\nORDER BY t.$orderBy ');
    if (limit != null) writer.write('\nLIMIT $limit ');
    if (offset != null) writer.write('\nOFFSET $offset ');
    writer.write(';');

    return writer.toString();
  }

  /// Generates a delete statement for the given [table].
  ///
  /// ```sql
  /// DELETE FROM table
  /// WHERE column = value;
  /// ```
  static String deleteStatement(
    String table, {
    String? where,
  }) {
    final writer = StringBuffer('DELETE FROM $table ');
    if (where != null) writer.write('\nWHERE $where ');
    writer.write(';');

    return writer.toString();
  }
}
