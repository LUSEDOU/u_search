import 'package:app_domain/app_domain.dart';
import 'package:postgres_client/postgres_client.dart';
import 'package:u_search_api/api.dart' show Apply, DataSource;
import 'package:uuid/v4.dart';

class MysqlSource implements DataSource {
  const MysqlSource({
    required PostgresClient client,
  }) : _client = client;

  final PostgresClient _client;

  @override
  Future<int> addApplication(Apply apply) async {
    return _client.upsert('applications', {
      'id': apply.id,
      'contest_id': apply.contest.id,
      'research_id': apply.research.id,
      'reviewer_id': null,
    });
  }

  @override
  Future<int> addContest(Contest contest) {
    return _client.upsert('contests', contest.toJson());
  }

  @override
  Future<int> addResearch(Research research) {
    return _client.upsert('researches', research.toJson());
  }

  @override
  Future<int> addReview(Review review) {
    return _client.upsert('reviews', review.toJson());
  }

  @override
  Future<int> addUser(User user) {
    return _client.upsert('users', user.toJson());
  }

  @override
  Future<Apply?> getApplication(int id) async {
    final result = await _client.selectOne(
      'applications',
      where: 'id = $id',
    );

    if (result == null) return null;
    final apply = Application.fromJson(result);
    return _getApplication(apply);
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
  Future<List<Apply>> getApplications() async {
    final result = await _client.select('applications');
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
  Future<List<Research>> getResearches() async {
    final result = await _client.select('researches');
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
    await _client.upsert(
      'tokens',
      {
        'token': token,
        'user_id': userId,
      },
      conflictColumn: 'user_id',
    );
    return token;
  }

  @override
  Future<String> getEmailToken(String token) async {
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
    await _client.upsert(
      'email_token',
      {
        'token': token,
        'email': email,
      },
      conflictColumn: 'email',
    );
    return token;
  }

  @override
  Future<List<User>> getUsers({int? role}) async {
    final result = await _client.select('users');
    return result.map(User.fromJson).toList();
  }

  @override
  Future<void> updateApplication(Apply apply) {
    return _client.upsert('applications', apply.toJson());
  }
}
