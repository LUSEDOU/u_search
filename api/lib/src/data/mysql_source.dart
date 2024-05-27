import 'package:app_domain/app_domain.dart';
import 'package:my_sql_client/my_sql_client.dart';
import 'package:u_search_api/api.dart' show Apply, DataSource;
import 'package:uuid/v4.dart';

/// {@template mysql_source}
/// A [DataSource] that uses a MySQL database as its source.
/// {@endtemplate}
class MysqlSource implements DataSource {
  /// {@macro mysql_source}
  const MysqlSource({
    required MySqlClient client,
  }) : _client = client;

  final MySqlClient _client;

  @override
  Future<int> addApplication(Application application) {
    return _client.upsert('applications', application.toJson()..remove('id'));
  }

  @override
  Future<int> addContest(Contest contest) {
    return _client.upsert('contests', contest.toJson()..remove('id'));
  }

  @override
  Future<int> addResearch(Research research) {
    return _client.upsert('researches', research.toJson()..remove('id'));
  }

  @override
  Future<int> addReview(Review review) {
    return _client.upsert('reviews', review.toJson()..remove('id'));
  }

  @override
  Future<int> addUser(User user) {
    return _client.upsert('users', user.toJson()..remove('id'));
  }

  @override
  Future<Application?> getApplicationRaw(int id) async {
    final result = await _client.selectOne(
      'applications',
      where: 'id = $id',
    );

    if (result == null) return null;
    return Application.fromJson(result);
  }

  @override
  Future<Apply?> getApplication(int id) async {
    final application = await getApplicationRaw(id);
    if (application == null) return null;
    return _getApplication(application);
  }

  Future<Apply?> _getApplication(Application id) async {
    final contest = await getContest(id.contest);
    final research = await getResearch(id.research);

    if (contest == null || research == null) return null;

    final reviewer = id.reviewer != null ? await getUser(id.reviewer!) : null;
    final review = id.review != null ? await getReview(id.review!) : null;

    return Apply(
      contest: contest,
      research: research,
      id: id.id,
      reviewer: reviewer,
      review: review,
    );
  }

  @override
  Future<List<Apply>> getApplications({
    int? reviewerId,
    int? researcherId,
  }) async {
    late final List<Map<String, dynamic>> result;

    if (researcherId != null) {
      result = await _client.select(
        'applications',
        where: 'reviewer_id = $reviewerId',
        join: 'INNER JOIN researches r ON r.id = t.research',
      );
    } else if (reviewerId != null) {
      result = await _client.select(
        'applications',
        where: 'reviewer = $reviewerId',
      );
    }
    final applications = result.map(Application.fromJson).toList();

    final applies = await Future.wait(
      applications.map(_getApplication),
    );
    //return all not nulls
    return applies.whereType<Apply>().toList();
  }

  @override
  Future<Contest?> getContest(int id) {
    return _client
        .selectOne(
          'contests',
          where: 'id = $id',
        )
        .then((result) => result == null ? null : Contest.fromJson(result));
  }

  @override
  Future<List<Contest>> getContests() async {
    final result = await _client.select('contests');
    return result.map(Contest.fromJson).toList();
  }

  @override
  Future<Research?> getResearch(int id) {
    return _client
        .selectOne(
          'researches',
          where: 'id = $id',
        )
        .then((result) => result == null ? null : Research.fromJson(result));
  }

  @override
  Future<List<Research>> getResearches({
    int? researcherId,
  }) async {
    late final List<Map<String, dynamic>> result;
    result = await _client.select(
      'researches',
      where: researcherId == null ? null : 'researcher_id = $researcherId',
    );
    return result.map(Research.fromJson).toList();
  }

  @override
  Future<Review?> getReview(int id) {
    return _client
        .selectOne(
          'reviews',
          where: 'id = $id',
        )
        .then((result) => result == null ? null : Review.fromJson(result));
  }

  @override
  Future<User?> getUser(int id) {
    return _client
        .selectOne(
          'users',
          where: 'id = $id',
        )
        .then((result) => result == null ? null : User.fromJson(result));
  }

  @override
  Future<User?> getUserByEmail(String email) {
    return _client
        .selectOne(
          'users',
          where: 'email = $email',
        )
        .then((result) => result == null ? null : User.fromJson(result));
  }

  @override
  Future<User?> getUserByToken(String token) async {
    final result = await _client.selectOne('tokens', where: 'token = $token');

    if (result == null) return null;

    final userId = result['user_id'] as int;
    return getUser(userId);
  }

  @override
  Future<String> generateToken(int userId) async {
    final token = const UuidV4().generate();
    await _client.upsert('tokens', {
      'token': token,
      'user_id': userId,
    });
    return token;
  }

  @override
  Future<String> getEmailFromToken(String token) async {
    final result = await _client.selectOne(
      'email_token',
      where: 'token = $token',
    );

    if (result == null) return '';

    return result['email'] as String;
  }

  @override
  Future<String> generateEmailToken(String email) async {
    final token = const UuidV4().generate();
    await _client.upsert('email_token', {
      'token': token,
      'email': email,
    });
    return token;
  }

  @override
  Future<List<User>> getUsers({int? role}) async {
    final result = await _client.select(
      'users',
      where: role == null ? null : 'role = $role',
    );
    return result.map(User.fromJson).toList();
  }

  @override
  Future<void> updateApplication(Application application) {
    return _client.upsert('applications', application.toJson());
  }

  @override
  Future<User?> getResearcherFromApply(int applyId) async {
    final result = await _client.select(
      'users',
      join: 'INNER JOIN researches r ON r.researcher_id = t.id '
          'INNER JOIN applications a ON a.research_id = r.id',
      where: 'a.id = $applyId',
      limit: 1,
    );

    if (result.isEmpty) return null;

    return User.fromJson(result.first);
  }
}
