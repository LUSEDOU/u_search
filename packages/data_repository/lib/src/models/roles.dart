part of 'role.dart';

/// {@template researcher}
/// Researcher
/// {@endtemplate}
final class Researcher extends Role {
  /// {@macro researcher}
  const Researcher({
    required super.id,
    super.user,
  });

  /// Returns a json representation of the researcher
  factory Researcher.fromJson(Map<String, dynamic> json) {
    final role = Role.fromJson(json);
    if (role.type != RoleType.researcher) {
      throw ArgumentError.value(
        json,
        'json',
        'Role type must be researcher',
      );
    }
    return Researcher(
      id: role.id,
      user: role.user,
    );
  }

  @override
  RoleType get type => RoleType.researcher;

  /// Returns an empty researcher
  static const Researcher empty = Researcher(id: 0);
}

/// {@template reviewer}
/// Reviewer
/// {@endtemplate}
final class Reviewer extends Role {
  /// {@macro reviewer}
  const Reviewer({
    required super.id,
    super.user,
  });

  /// Returns a json representation of the reviewer
  factory Reviewer.fromJson(Map<String, dynamic> json) {
    final role = Role.fromJson(json);
    if (role.type != RoleType.reviewer) {
      throw ArgumentError.value(
        json,
        'json',
        'Role type must be reviewer',
      );
    }
    return Reviewer(
      id: role.id,
      user: role.user,
    );
  }

  @override
  RoleType get type => RoleType.reviewer;

  /// Returns an empty reviewer
  static const Reviewer empty = Reviewer(id: -1);
}

/// {@template admin}
/// Admin
/// {@endtemplate}
final class Admin extends Role {
  /// {@macro admin}
  const Admin({
    required super.id,
    super.user,
  });

  /// Returns a json representation of the admin
  factory Admin.fromJson(Map<String, dynamic> json) {
    final role = Role.fromJson(json);
    if (role.type != RoleType.admin) {
      throw ArgumentError.value(
        json,
        'json',
        'Role type must be admin',
      );
    }
    return Admin(
      id: role.id,
      user: role.user,
    );
  }

  @override
  RoleType get type => RoleType.admin;

  /// Returns an empty admin
  static const Admin empty = Admin(id: 0);
}

/// {@template unknown_role}
/// Unknown role
/// {@endtemplate}
final class Unknown extends Role {
  /// {@macro unknown_role}
  const Unknown({
    super.user,
  }) : super(
          id: -1,
          type: RoleType.unknown,
        );
}
