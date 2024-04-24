import 'package:collection/collection.dart';
import 'package:u_search_api/api.dart';
import 'package:uuid/v4.dart';

part 'static_data.dart';

class InMemoryDataSource implements DataSource {
  @override
  Future<int> addApplication(Application application) {
    final length = _applications.length;
    final uAppplication = application.copyWith(id: length);
    _applications.add(uAppplication);
    return Future.value(length);
  }

  @override
  Future<int> addContest(Contest contest) {
    final length = _contests.length;
    final uContest = contest.copyWith(id: length);
    _contests.add(uContest);
    return Future.value(length);
  }

  @override
  Future<int> addResearch(Research research) {
    final length = _researches.length;
    final uResearch = research.copyWith(id: length);
    _researches.add(uResearch);
    return Future.value(length);
  }

  @override
  Future<int> addReview(Review review) {
    final length = _reviews.length;
    final uReview = Review(
      id: length,
      calification: review.calification,
      criterias: review.criterias,
    );
    _reviews.add(uReview);
    return Future.value(length);
  }

  @override
  Future<int> addUser(User reviewer) {
    final length = _users.length;
    final uReviewer = reviewer.copyWith(id: length);
    _users.add(uReviewer);
    return Future.value(length);
  }

  @override
  Future<String> generateEmailToken(String email) {
    final token = const UuidV4().generate();
    _emailTokens[email] = token;
    return Future.value(token);
  }

  @override
  Future<String> generateToken(int userId) {
    return Future.value(_tokens[userId] ?? 'admin');
  }

  @override
  Future<Apply?> getApplication(int id) {
    final application = _applications.firstWhereOrNull(
      (element) => element.id == id,
    );

    if (application == null) return Future.value();

    final contest = _contests.firstWhereOrNull(
      (element) => element.id == application.contest,
    );
    final research = _researches.firstWhereOrNull(
      (element) => element.id == application.research,
    );
    final review = _reviews.firstWhereOrNull(
      (element) => element.id == application.review,
    );
    final reviewer = _users.firstWhereOrNull(
      (element) => element.id == application.reviewer,
    );

    if (contest == null || research == null) return Future.value();

    return Future.value(
      Apply(
        id: application.id,
        contest: contest,
        research: research,
        review: review,
        reviewer: reviewer,
      ),
    );
  }

  @override
  Future<Application?> getApplicationRaw(int id) {
    final application = _applications.firstWhereOrNull(
      (element) => element.id == id,
    );
    return Future.value(application);
  }

  @override
  Future<List<Apply>> getApplications({
    int? researcherId,
    int? reviewerId,
  }) async {
    final applications = await Future.wait(
      _applications.map((e) => getApplication(e.id)),
    );
    applications.removeWhere((element) => element == null);

    if (researcherId != null) {
      applications.removeWhere(
        (element) => element!.research.researcher != researcherId,
      );
    } else if (reviewerId != null) {
      applications.removeWhere(
        (element) => element!.reviewer?.id != reviewerId,
      );
    }

    return Future.value(applications.cast<Apply>());
  }

  @override
  Future<Contest?> getContest(int id) {
    return Future.value(
      _contests.firstWhereOrNull(
        (element) => element.id == id,
      ),
    );
  }

  @override
  Future<List<Contest>> getContests() {
    return Future.value(_contests);
  }

  @override
  Future<String?> getEmailToken(String token) {
    return Future.value(_emailTokens[token]);
  }

  @override
  Future<Research?> getResearch(int id) {
    return Future.value(
      _researches.firstWhereOrNull(
        (element) => element.id == id,
      ),
    );
  }

  @override
  Future<User?> getResearcherForApply(int applyId) {
    final apply = _applications.firstWhereOrNull(
      (element) => element.id == applyId,
    );

    if (apply == null) return Future.value();

    final research = _researches.firstWhereOrNull(
      (element) => element.id == apply.research,
    );

    if (research == null) return Future.value();

    return Future.value(
      _users.firstWhereOrNull(
        (element) => element.id == research.researcher,
      ),
    );
  }

  @override
  Future<List<Research>> getResearches({int? researcherId}) {
    return Future.value(
      _researches
          .where(
            (element) =>
                researcherId == null || element.researcher == researcherId,
          )
          .toList(),
    );
  }

  @override
  Future<Review?> getReview(int applyId) {
    final application = _applications.firstWhereOrNull(
      (element) => element.id == applyId,
    );
    if (application == null) return Future.value();

    return Future.value(
      _reviews.firstWhereOrNull(
        (element) => element.id == application.review,
      ),
    );
  }

  @override
  Future<User?> getUser(int id) {
    return Future.value(
      _users.firstWhereOrNull(
        (element) => element.id == id,
      ),
    );
  }

  @override
  Future<User?> getUserByEmail(String email) {
    return Future.value(
      _users.firstWhereOrNull(
        (element) => element.email == email,
      ),
    );
  }

  @override
  Future<User?> getUserByToken(String token) {
    return Future.value(
      _users.firstWhereOrNull(
        (element) => _tokens[element.id] == token,
      ),
    );
  }

  @override
  Future<List<User>> getUsers({int? role}) {
    return Future.value(
      _users
          .where(
            (element) => role == null || element.role.value == role,
          )
          .toList(),
    );
  }

  @override
  Future<void> updateApplication(Application application) {
    final index = _applications.indexWhere(
      (element) => element.id == application.id,
    );

    if (index == -1) return Future.value();

    final uApplication = application.copyWith(id: index);

    _applications[index] = uApplication;

    return Future.value();
  }
}
