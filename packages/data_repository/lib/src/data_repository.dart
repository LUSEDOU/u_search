import 'dart:io';

import 'package:data_repository/data_repository.dart';

/// {@template data_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class DataRepository {
  /// {@macro data_repository}
  const DataRepository(
    ApiClient client,
  )   : _client = client;

  final ApiClient _client;

  /// Returns a List of [Contest]s.
  Future<List<Contest>> getContests() => _client.getContests();

  /// Returns a Stream of List of [Apply]s.
  Future<Stream<List<Apply>>> getApplies() => _client.getApplies();

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
}
