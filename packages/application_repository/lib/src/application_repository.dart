import 'dart:async';
// import 'dart:convert';
// import 'dart:html' as html;
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
// import 'package:path_provider/path_provider.dart';
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
      _applicationController.add(response.applications);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(ApplicationFetchFailure(error), stackTrace);
    }
  }

  /// Fetches an [Apply] from the repository.
  ///
  /// Throws an [ApplicationFetchFailure] if an error occurs.
  Future<Apply> fetchApplication(int id) async {
    try {
      final response = await _apiClient.getApply(id: id);
      final current = [..._applicationController.value];

      final index = current.indexWhere((element) => element.id == id);
      if (index == -1) {
        _applicationController.add([...current, response]);
      } else {
        current[index] = response;
        _applicationController.add(current);
      }

      return response;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(ApplicationFetchFailure(error), stackTrace);
    }
  }

  /// Fetches all [User]s from the repository.
  ///
  /// Throws an [ApplicationFetchReviewersFailure] if an error occurs.
  // TODO(LUSEDOU): Change Failure to ApplicationFetchUsersFailure
  Future<List<User>> fetchUsers() async {
    try {
      final response = await _apiClient.getUsers();
      return response.users;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        ApplicationFetchReviewersFailure(error),
        stackTrace,
      );
    }
  }

  /// Updates a [User] in the repository.
  ///
  /// Throws an [ApplicationFetchReviewersFailure] if an error occurs.
  // TODO(LUSEDOU): Change Failure to ApplicationUpdateUserFailure
  Future<void> updateUser(User user) async {
    try {
      await _apiClient.updateUser(id: user.id, user: user);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        ApplicationFetchReviewersFailure(error),
        stackTrace,
      );
    }
  }

  /// Invites a [User] and adds them to the repository.
  ///
  /// Throws an [ApplicationFetchReviewersFailure] if an error occurs.
  // TODO(LUSEDOU): Change Failure to ApplicationInviteUserFailure
  Future<User> inviteUser(User user) async {
    try {
      return await _apiClient.createUser(user: user);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        ApplicationFetchReviewersFailure(error),
        stackTrace,
      );
    }
  }

  /// Apply a reasearch paper to a contest.
  ///
  /// Throws an [ApplicationApplyFailure] if an error occurs.
  Future<Apply> apply({
    required int contest,
    required Uint8List research,
    required String title,
  }) async {
    try {
      final researchResponse = await _apiClient.submitResearch(
        title: title,
        bytes: research,
      );

      final researchId = researchResponse.id;

      final apply = await _apiClient.apply(
        contest: contest,
        research: researchId,
      );
      _applicationController.add([..._applicationController.value, apply]);

      return apply;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(ApplicationApplyFailure(error), stackTrace);
    }
  }

  /// Update an [Apply] with a selected reviewer.
  ///
  /// Throws an [ApplicationSelectReviewerFailure] if an error occurs.
  Future<Apply> selectReviewer({
    required Apply apply,
    required User reviewer,
  }) async {
    try {
      await _apiClient.selectReviewer(apply: apply.id, reviewer: reviewer.id);
      final updated = apply.copyWith(reviewer: reviewer);
      final current = [..._applicationController.value];

      final index = current.indexWhere((element) => element.id == apply.id);
      current[index] = updated;
      _applicationController.add(current);
      return updated;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        ApplicationSelectReviewerFailure(error),
        stackTrace,
      );
    }
  }

  /// Fetches all [Contest]s from the repository.
  ///
  /// Throws an [ApplicationFetchContestsFailure] if an error occurs.
  Future<List<Contest>> fetchContests() async {
    try {
      final response = await _apiClient.getContests();
      return response.contests;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        ApplicationFetchContestsFailure(error),
        stackTrace,
      );
    }
  }

  /// Fetches a [Contest] from the repository.
  ///
  /// Throws an [ApplicationFetchContestsFailure] if an error occurs.
  Future<Contest> fetchContest(int id) async {
    try {
      final response = await _apiClient.getContest(id: id);
      return response;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        ApplicationFetchContestFailure(error),
        stackTrace,
      );
    }
  }

  /// Fetches all [User]s that are reviewers.
  ///
  /// Throws an [ApplicationFetchReviewersFailure] if an error occurs.
  Future<List<User>> fetchReviewers() async {
    try {
      final response = await _apiClient.getReviewers();
      return response.users;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        ApplicationFetchReviewersFailure(error),
        stackTrace,
      );
    }
  }

  Future<Review> fetchReview(int applyId) async {
    try {
      final response = await _apiClient.getReview(apply: applyId);
      return response;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        ApplicationFetchReviewFailure(error),
        stackTrace,
      );
    }
  }

  Future<Review> review({
    required int apply,
    required Review review,
  }) async {
    try {
      final ureview = await _apiClient.submitReview(
        apply: apply,
        review: review,
      );
      final current = [..._applicationController.value];

      final index = current.indexWhere((element) => element.id == apply);
      current[index] = current[index].copyWith(review: ureview);
      _applicationController.add(current);
      return ureview;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(ApplicationReviewFailure(error), stackTrace);
    }
  }

  /// Returns the base64 string of the research
  Future<String> downloadResearch(Research research) async {
    try {
      // final downloadPath =
      // (await getDownloadsDirectory() ??
      //     await getApplicationDocumentsDirectory())

      return await _apiClient.downloadResearch(research: research.id);

      // final anchor = html.AnchorElement(
      //   href: 'localhost:8080/researches/${research.uuid}.pdf',
      // )

      // final anchor = html.AnchorElement(
      //   href: 'data:application/octet-stream;base64,$base64',
      // )
      //   ..target = 'blank'
      //   ..download = research.title;
      //
      // html.document.body?.append(anchor);
      // anchor
      //   ..click()
      //   ..remove();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        ApplicationDownloadResearchFailure(error),
        stackTrace,
      );
    }
  }
}
