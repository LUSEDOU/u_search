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
    @JsonKey(required: true) required String email,

    /// User's name
    @JsonKey(required: true) required String name,

    /// User id
    @JsonKey(required: true) int? id,
  }) = _User;

  /// {@macro user}
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
