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
