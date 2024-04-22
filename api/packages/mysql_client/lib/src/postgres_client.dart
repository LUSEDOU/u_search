import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:mysql/mysql.dart';

/// {@template mysql_client}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class PostgresClient {
  /// {@macro mysql_client}
  const PostgresClient({
    required Connection connection,
    Logger? logger,
  })  : _connection = connection,
        _logger = logger;

  final Connection _connection;
  final Logger? _logger;

  Future<void> close() async {
    _logger?.info('Closing connection');
    await _connection.close();
  }

  Future<int> upsert(
    String table,
    Map<String, dynamic> value, {
    String conflictColumn = 'id',
  }) async {
    final statement = Helper.upsertStatement(
      table,
      value,
      conflictColumn: conflictColumn,
    );
    _logger?.info('Upserting: $statement');

    final result = await _connection.execute(statement);
    _logger?.info('Upserted: $result');

    final id = result.first.first;

    if (id is! int) {
      throw Exception('Invalid id: $id');
    }

    return id;
  }

  Future<List<Map<String, dynamic>>> select(
    String table, {
    String? where,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final statement = Helper.selectStatement(
      table,
      where: where,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
    _logger?.info('Selecting: $statement');

    final result = await _connection.execute(statement);
    _logger?.info('Selected: $result');
    return result.map((row) => row.toColumnMap()).toList();
  }

  Future<Map<String, dynamic>?> selectOne(
    String table, {
    String? where,
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

  static String upsertStatement(
    String table,
    Map<String, dynamic> value, {
    String conflictColumn = 'id',
    String returnColumn = 'id',
  }) {
    final columns = value.keys.join(', ');
    final values = value.values.map(parseValue).join(', ');

    final writer = StringBuffer('''
    INSERT INTO $table ($columns)
    VALUES ($values)
    ON CONFLICT ($conflictColumn)
    DO UPDATE SET
    ''');

    for (final column in value.keys) {
      if (column == conflictColumn) continue;

      writer.write('''
      $column = EXCLUDED.$column,
      ''');
    }

    writer.write('''
    RETURNING $returnColumn;
    ''');

    return writer.toString();
  }

  static String selectStatement(
    String table, {
    String? where,
    String? orderBy,
    int? limit,
    int? offset,
  }) {
    final writer = StringBuffer('''
    SELECT * FROM $table
    ''');

    if (where != null) {
      writer.write('''
      WHERE $where
      ''');
    }

    if (orderBy != null) {
      writer.write('''
      ORDER BY $orderBy
      ''');
    }

    if (limit != null) {
      writer.write('''
      LIMIT $limit
      ''');
    }

    if (offset != null) {
      writer.write('''
      OFFSET $offset
      ''');
    }

    writer.write(';');

    return writer.toString();
  }

  static String deleteStatement(
    String table, {
    String? where,
  }) {
    final writer = StringBuffer('''
    DELETE FROM $table
    ''');

    if (where != null) {
      writer.write('''
      WHERE $where
      ''');
    }

    writer.write(';');

    return writer.toString();
  }
}
