import 'package:freezed_annotation/freezed_annotation.dart';

part 'role.freezed.dart';
part 'role.g.dart';

/// {@template role_type}
/// A type of a role.
/// {@endtemplate}
enum RoleType {
  /// Researcher
  @JsonValue(0)
  researcher._('Researcher', id: 0),

  /// Reviewer
  @JsonValue(1)
  reviewer._('Reviewer', id: 1),

  /// Admin
  @JsonValue(2)
  admin._('Admin', id: 2),

  /// Unknown
  unknown._('Unknown', id: -1);

  const RoleType._(
    this.name, {
    required this.id,
  });

  /// Role name
  final String name;

  /// Role id
  final int id;
}

/// {@template role}
/// A role for a user.
/// {@endtemplate}
@freezed
class Role with _$Role {
  /// {@macro role}
  const factory Role({
    /// Role id
    required int id,

    /// Role type
    required RoleType type,
  }) = _Role;

  /// {@macro role}
  const Role._();

  /// Empty role
  static const empty = Role(
    id: -1,
    type: RoleType.unknown,
  );

  /// {@macro role}
  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);
}
