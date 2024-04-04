import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'role.g.dart';
part 'roles.dart';

/// {@template role_type}
/// A type of a role.
/// {@endtemplate}
@JsonEnum(valueField: 'id')
enum RoleType {
  /// Researcher
  researcher._('Investigador', id: 0),

  /// Reviewer
  reviewer._('Evaluador', id: 1),

  /// Admin
  admin._('Administrador', id: 2),

  /// Unknown
  unknown._('Unknown');

  const RoleType._(
    this.name, {
    this.id = -1,
  });

  /// Role name
  final String name;

  /// Role id
  final int id;

  /// Permitted roles
  static const permitted = [
    RoleType.researcher,
    RoleType.reviewer,
  ];
}

/// {@template role}
/// A role for a user.
/// {@endtemplate}
@JsonSerializable()
class Role extends Equatable {
  /// {@macro role}
  const Role({
    required this.id,
    this.type = RoleType.unknown,
    this.user = User.empty,
  });

  /// Role id
  final int id;

  /// Role type
  final RoleType type;

  /// User role
  final User user;

  ///
  static Role fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  /// Makes a copy of a Role
  Role copyWith({
    int? id,
    RoleType? type,
    User? user,
  }) {
    return Role(
      id: id ?? this.id,
      type: type ?? this.type,
      user: user ?? this.user,
    );
  }

  /// Returns an empty role
  static const Role empty = Role(id: -1);

  /// Returns true if this [Role] is empty
  bool get isEmpty => this == Role.empty;

  /// Returns true if this [Role] is empty
  bool get isCreated => id != -1;

  /// Converts a Role to a json map
  Map<String, dynamic> toJson() => _$RoleToJson(this);

  @override
  List<Object> get props => [id, type, user];
}
