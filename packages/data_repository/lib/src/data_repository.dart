import 'dart:io';

import 'package:cache_client/cache_client.dart';
import 'package:data_repository/data_repository.dart';

/// {@template data_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class DataRepository {
  /// {@macro data_repository}
  const DataRepository({
    required ApiClient client,
    required CacheClient cache,
    required DataCacheKeys cacheKeys,
  })  : _client = client,
        _cache = cache,
        _keys = cacheKeys;

  final ApiClient _client;
  final CacheClient _cache;
  final DataCacheKeys _keys;

  /// Returns a Stream of [Role]s.
  Stream<Role> get role => _client.roleChanges().map((role) {
        final newRole = role ?? const Unknown();
        _cache.write(key: _keys.roleCacheKey, value: newRole);
        return newRole;
      });

  /// Returns the current [Role] from the cache.
  Role get currentRole {
    final role = _cache.read<Role>(key: _keys.roleCacheKey);

    if (role == null) {
      return const Unknown();
    }

    return switch (role.type) {
      RoleType.admin => Admin(
          id: role.id,
          user: role.user,
        ),
      RoleType.researcher => Researcher(
          id: role.id,
          user: role.user,
        ),
      RoleType.reviewer => Reviewer(
          id: role.id,
          user: role.user,
        ),
      RoleType.unknown => Unknown(
          user: role.user,
        ),
    };
  }

  /// Adds a [user] and returns it.
  Future<User> addUser(User user) => _client.addUser(user);

  /// Adds a [role] to the current user.
  Future<Role> addRoleToUser(Role role, {required User user}) =>
      _client.addRoleToUser(role, user: user);

  Role updateRole(Role role) => _client.updateRole(role);

  /// Logs out the current role.
  void logOut() => _client.logout();

  /// Returns a List of [Contest]s.
  Future<List<Contest>> getContests() => _client.getContests();

  /// Returns a Stream of List of [Apply]s for the given [role].
  Future<Stream<List<Apply>>> getApplies({
    required Role role,
  }) =>
      _client.getApplies(role: role);

  Future<Apply> updateApply(Apply apply) => _client.updateApply(apply);

  /// Updates a [user] if it exists, otherwise creates it, then returns it.
  Future<User> upsertUser(User user) => _client.upsertUser(user);

  /// Uploads a [research] file
  /// Returns the Uuid of the uploaded file.
  Future<String> uploadResearchFile({
    required File research,
  }) =>
      _client.uploadResearchFile(
        research: research,
      );

  /// Adds a [research]
  Future<Research> addResearch(Research research) =>
      _client.addResearch(research);

  /// Adds an [Apply] and returns it.
  Future<Apply> addApply(Apply apply) => _client.addApply(apply);

  /// Returns an [Apply] with the given [id].
  Future<Apply> getApply(int id) => _client.getApply(id);

  Future<Review> addReview(Review review) => _client.addReview(review);

  Future<bool> validateCode(String code, int type) =>
      _client.validateCode(code, type);

  Future<List<Role>> getEvaluators() => _client.getEvaluators();
}
