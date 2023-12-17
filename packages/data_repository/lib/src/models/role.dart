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
  researcher._('Researcher', id: 0),

  /// Reviewer
  reviewer._('Reviewer', id: 1),

  /// Admin
  admin._('Admin', id: 2),

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
    RoleType.admin,
  ];
}

/// {@template role_type_x}
/// Extension for [RoleType]
/// {@endtemplate}
extension RoleTypeX on RoleType {
  /// Role is researcher
  bool get isResearcher => this == RoleType.researcher;

  /// Role is reviewer
  bool get isReviewer => this == RoleType.reviewer;

  /// Role is admin
  bool get isAdmin => this == RoleType.admin;

  /// Role is unknown
  bool get isUnknown => this == RoleType.unknown;

  /// Role is permitted
  bool get isPermitted => RoleType.permitted.contains(this);

  /// Role is not permitted
  bool get isNotPermitted => !isPermitted;
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

  /// Converts a Role to a json map
  Map<String, dynamic> toJson() => _$RoleToJson(this);

  @override
  List<Object> get props => [id, type, user];
}
