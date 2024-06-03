import 'dart:convert';

import 'package:logging/logging.dart';

/// {@template sql_client}
/// A interface of a SQL client
/// {@endtemplate}
abstract class SqlClient {
  /// {@macro sql_client}
  const SqlClient({
    required SqlBuilder builder,
    Logger? logger,
  })  : _logger = logger,
        _builder = builder;

  /// The logger for the client.
  final Logger? _logger;

  /// The builder for the client.
  final SqlBuilder _builder;

  /// Closes the connection to the database.
  Future<void> close();

  /// Upserts a record into the given [table] with the given [value].
  /// And returns the id of the upserted record.
  Future<int> upsert(
    String table,
    Map<String, dynamic> value,
  );

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
  });

  /// Selects a single record from the given [table] with the given
  /// [where] clause.
  Future<Map<String, dynamic>?> selectOne(
    String table, {
    String? where,
    String? join,
  });

  /// Deletes records from the given [table] with the given [where] clause.
  Future<void> delete(
    String table, {
    String? where,
  });
}

/// {@template sql_builder}
/// A helper class for building SQL statements.
/// {@endtemplate}
abstract class SqlBuilder {
  /// {@macro sql_builder}
  const SqlBuilder();

  /// Parses the given [value] into a SQL value.
  dynamic parseValue(dynamic value) {
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
  String deleteStatement(
    String table, {
    String? where,
  });
}
