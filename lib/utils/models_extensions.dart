import 'package:authentication_repository/authentication_repository.dart'
    as auth;
import 'package:data_repository/data_repository.dart';

extension UserX on auth.User {
  User toModel({String? name}) {
    return User(
      email: email ?? '',
      name: name ?? this.name ?? '',
      id: id,
    );
  }
}

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

extension RoleX on Role {
  /// Role is researcher
  bool get isResearcher => type.isResearcher;

  /// Role is reviewer
  bool get isReviewer => type.isReviewer;

  /// Role is admin
  bool get isAdmin => type.isAdmin;

  /// Role is unknown
  bool get isUnknown => type.isUnknown;

  /// Role is permitted
  bool get isPermitted => type.isPermitted;

  /// Role is not permitted
  bool get isNotPermitted => type.isNotPermitted;

  /// Role is created
  bool get isCreated => id != -1;
}
