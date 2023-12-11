import 'dart:io';

import 'package:data_repository/data_repository.dart';

abstract class ApiClient {
  Future<List<Contest>> getContests();

  Future<Stream<List<Apply>>> getApplies();

  Stream<Role?> roleChanges();

  Future<Role> addRoleToUser(Role role, {required User user});

  Role updateRole(Role role);

  void logout();

  Future<User> upsertUser(User user);

  Future<Apply> getApply(int id);

  Future<String> uploadResearchFile({
    required File research,
  });

  Future<Research> addResearch(Research research);

  Future<Apply> addApply(Apply apply);

  Future<Review> addReview(Review review);

  Future<bool> validateCode(String code, int type);

  Future<User> addUser(User user);
}
