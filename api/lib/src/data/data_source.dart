//ignore_for_file: public_member_api_docs
import 'package:u_search_api/api.dart';

abstract class DataSource {
  Future<List<Apply>> getApplications();
  Future<Apply?> getApplication(int id);
  Future<void> addApplication(Apply apply);
  Future<void> updateApplication(Apply apply);

  Future<List<Contest>> getContests();
  Future<Contest?> getContest(int id);
  Future<void> addContest(Contest contest);

  Future<List<Research>> getResearches();
  Future<Research?> getResearch(int id);
  Future<void> addResearch(Research research);

  Future<List<User>> getUsers({
    int? role,
  });
  Future<User?> getUser(int id);
  Future<void> addUser(User reviewer);

  Future<Review?> getReview(int id);
  Future<void> addReview(Review review);
}
