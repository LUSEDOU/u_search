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
    /// User id
    @JsonKey(required: true) required int id,

    /// User email
    @JsonKey(required: true) String? email,

    /// User's name
    @JsonKey(required: true) String? name,
  }) = _User;
  const User._();

  /// {@macro user}
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Empty user which represents an unauthenticated user.
  static const User empty = User(id: -1);

  /// Returns `true` if this user is empty.
  bool get isEmpty => this == User.empty;

  /// Returns `true` if this user is not empty.
  bool get isNotEmpty => this != User.empty;
}
