import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// {@template user}
/// A class that represents a user.
/// {@endtemplate}
@JsonSerializable()
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.lastName,
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

  /// Converts a `User` instance to a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [id, name, email, lastName];
}
