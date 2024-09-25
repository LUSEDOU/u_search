import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// {@template user}
/// A class that represents a user.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.lastName,
    this.role = Role.none,
  });

  /// Converts a `Map<String, dynamic>` to a `User` instance.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// The current user's id.
  final int id;

  /// The current user's name.
  final String name;

  /// The current user's last name.
  final String lastName;

  /// The current user's email.
  final String email;

  /// The current user's role.
  final Role role;

  /// Whether the user is anonymous.
  bool get isAnonymous => User.anonymous == this;

  /// An anonymous user.
  static const User anonymous = User(
    id: 0,
    name: '',
    lastName: '',
    email: '',
  );

  /// Converts a `User` instance to a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// Creates a new [User] with the provided fields.
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? lastName,
    Role? role,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      lastName: lastName ?? this.lastName,
      role: role ?? this.role,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        email,
        lastName,
      ];
}

/// An enum representing the role of a user.
@JsonEnum(valueField: 'value')
enum Role {
  /// A user with no role.
  none._(-1),

  /// A reviewer user.
  reviewer._(0, 'Revisor'),

  /// A researcher user.
  researcher._(1, 'Investigador'),

  /// An admin user.
  admin._(2, 'Administrador');

  const Role._(this.value, [this.label = '']);

  /// The value of the enum
  final int value;

  /// The name of the role.
  final String label;

  /// Whether the role is a reviewer.
  bool get isReviewer => this == Role.reviewer;
  /// Whether the role is a researcher.
  bool get isResearcher => this == Role.researcher;
  /// Whether the role is an admin.
  bool get isAdmin => this == Role.admin;
}
