import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:storage/storage.dart';
import 'package:u_search_api/api.dart';

part 'application_failure.dart';
part 'application_storage.dart';

/// {@template application_repository}
/// A repository that manages application data.
/// {@endtemplate}
class ApplicationRepository {
  /// {@macro application_repository}
  ApplicationRepository({
    required USearchApiClient apiClient,
  })  : _apiClient = apiClient,
        _applicationController = BehaviorSubject<List<Apply>>.seeded(const []);

  // final ApplicationStorage _storage;
  final USearchApiClient _apiClient;

  /// Stream of [Apply]s.
  ///
  /// Emits a new list of [Apply]s when the data changes.
  Stream<List<Apply>> get applications => _applicationController.stream;

  final BehaviorSubject<List<Apply>> _applicationController;

  /// Fetches all [Apply]s from the repository.
  ///
  /// Throws an [ApplicationFailure] if an error occurs.
  Future<void> fetchApplications() async {
    try {
      final response = await _apiClient.getApplies();
      _applicationController.add(response);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(ApplicationFetchFailure(error), stackTrace);
    }
  }

  /// Adds an [Apply] to the repository.
  ///
  /// Throws an [ApplicationSendApplyFailure] if an error occurs.
  Future<void> sendApplication(Apply apply) async {
    try {
      final current = [..._applicationController.value];
      if (apply.isCreated) {
        final response = await _apiClient.apply(
          // check the user in the api
          researcher: 0,
          contest: apply.contest.id,
          research: apply.research,
        );
        final index = current.indexWhere((element) => element.id == apply.id);
        current[index] = apply;
        _applicationController.add(current);
      } else {
        // final response = await _apiClient.sendApplication(apply);
        final response = apply.copyWith(id: 1);
        _applicationController.add([...current, response]);
      }
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(ApplicationSendApplyFailure(error), stackTrace);
    }
  }
}
