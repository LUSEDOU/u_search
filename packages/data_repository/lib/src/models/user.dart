// import 'package:equatable/equatable.dart';
// import 'package:u_search_api/src/models/apply.dart';
// import 'package:u_search_api/src/models/email.dart';
// import 'package:u_search_api/src/models/password.dart';
//
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// {@template user}
///  User model
/// {@endtemplate}
@freezed
class User with _$User {
  /// {@macro user}
  const factory User({
    /// User email
    required String email,

    /// User's name
    required String name,

    /// User id
    required String id,
  }) = _User;

  /// {@macro user}
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// {@macro user}
  const User._();

  /// Empty user
  static const empty = User(
    email: '',
    name: '',
    id: '',
  );

  /// User is empty
  bool get isEmpty => this == User.empty;

  /// User is not empty
  bool get isNotEmpty => this != User.empty;
}
