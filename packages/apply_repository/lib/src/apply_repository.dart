import 'package:u_search_api/u_search_api.dart';

/// {@template apply_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class ApplyRepository {
  /// {@macro apply_repository}
  const ApplyRepository({
    required USearchApi uSearchApi,
  }) : _uSearchApi = uSearchApi;

  /// The [USearchApi] used by this repository to send requests.
  final USearchApi _uSearchApi;

  /// Returns a [Stream] of [Apply]s which will emit new values when
  Stream<List<Apply>> getApplies() => _uSearchApi.getApplies();

  /// Saves an [Apply]
  ///
  /// If a [Apply] with matching ID already exists, the entry will be
  /// updated.
  Future<void> saveApply(Apply apply) => _uSearchApi.saveApply(apply);
}
