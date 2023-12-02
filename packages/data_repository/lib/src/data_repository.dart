import 'dart:io';

import 'package:data_repository/data_repository.dart';

/// {@template data_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class DataRepository {
  /// {@macro data_repository}
  const DataRepository(
    ApiClient client,
  ) : _client = client;

  final ApiClient _client;

  /// Returns a List of [Contest]s.
  Future<List<Contest>> getContests() => _client.getContests();

  Stream<List<Apply>> getApplies() => _client.getApplies();

  Future<String> uploadResearch({
    required int applicantId,
    required File research,
  }) =>
      _client.uploadResearch(
        applicantId: applicantId,
        research: research,
      );

    Future<Apply> getApply(int id) => _client.getApply(id);
}
