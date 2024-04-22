//ignore_for_file: public_member_api_docs
import 'package:u_search_api/api.dart';

abstract class DataSource {
  Future<List<Apply>> getApplications({
    int? researcherId,
    int? reviewerId,
  });

  Future<Application?> getApplicationRaw(int id);
  Future<Apply?> getApplication(int id);
  Future<int> addApplication(Application application);
  Future<void> updateApplication(Application application);

  Future<List<Contest>> getContests();
  Future<Contest?> getContest(int id);
  Future<int> addContest(Contest contest);

  Future<List<Research>> getResearches({
    int? researcherId,
  });

  Future<User?> getResearcherForApply(int applyId);
  Future<Research?> getResearch(int id);
  Future<int> addResearch(Research research);

  Future<List<User>> getUsers({
    int? role,
  });

  Future<User?> getUser(int id);
  Future<User?> getUserByEmail(String email);
  Future<User?> getUserByToken(String token);
  Future<int> addUser(User reviewer);

  Future<Review?> getReview(int id);
  Future<int> addReview(Review review);

  Future<String> generateToken(int userId);

  Future<String?> getEmailToken(String email);
  Future<String?> generateEmailToken(String email);
}
