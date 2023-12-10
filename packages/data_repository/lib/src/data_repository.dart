import 'dart:io';

import 'package:data_repository/data_repository.dart';
import 'package:data_repository/src/clients/cache_clients.dart';

/// {@template data_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class DataRepository {
  /// {@macro data_repository}
  const DataRepository(
    ApiClient client,
    CacheClient cache,
  )   : _client = client,
        _cache = cache;

  final ApiClient _client;
  final CacheClient _cache;

  Stream<Role> get role => _client.roleChanges().map((role) {
        final _role = role ?? Role.empty;
        _cache.write(key: _cache.roleCacheKey, value: _role);
        return _role;
      });

  Role get currentRole =>
      _cache.read<Role>(key: _cache.roleCacheKey) ?? Role.empty;

  Future<Role> addRoleToUser(Role role, {required User user}) =>
      _client.addRoleToUser(role, user: user);

  /// Returns a List of [Contest]s.
  Future<List<Contest>> getContests() => _client.getContests();

  /// Returns a Stream of List of [Apply]s.
  Future<Stream<List<Apply>>> getApplies() => _client.getApplies();

  Future<User> updateUser(User user) => _client.updateUser(user);

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
}
