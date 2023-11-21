import 'package:u_search_api/u_search_api.dart';

/// {@template u_search_api}
/// The interface that defines the API methods needed for this repository.
/// {@endtemplate}
abstract class USearchApi {
  /// {@macro u_search_api}
  const USearchApi();

  /// Returns a [Stream] of [Apply]s which will emit new values when
  /// the [Apply]s change.
  Stream<List<Apply>> getApplies();

  /// Saves an [Apply]
  ///
  /// If a [Apply] with matching ID already exists, the entry will be
  /// updated.
  Future<void> saveApply(Apply apply);
}
