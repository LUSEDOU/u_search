import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// {@template user}
/// User model
/// {@endtemplate}
@JsonSerializable()
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.email,
    required this.name,
    required this.id,
  });

  /// Converts a User from a json map
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// User email
  final String email;

  /// User's name
  final String name;

  /// User id
  final String id;

  /// Converts a User to a json map
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// Empty user
  static const User empty = User(
    email: '',
    name: '',
    id: '',
  );

  /// User is empty
  bool get isEmpty => this == User.empty;

  /// User is not empty
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, name, id];
}
