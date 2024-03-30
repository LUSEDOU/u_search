import 'package:authentication_client/authentication_client.dart';
import 'package:equatable/equatable.dart';
import 'package:storage/storage.dart';

part 'user_failure.dart';
part 'user_storage.dart';

/// {@template user_repository}
/// A repository that manages user data.
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  const UserRepository({
    required UserStorage storage,
    required AuthenticationClient authenticationClient,
  })  : _authenticationClient = authenticationClient,
        _storage = storage;

  final UserStorage _storage;
  final AuthenticationClient _authenticationClient;

  Future<void> sendLoginiEmailLink(String email) async {}
}
