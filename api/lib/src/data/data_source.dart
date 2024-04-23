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

  /// Returns the review for the given apply id.
  ///
  /// In case of no review, returns an editable review.
  /// Only returns null if the apply id is invalid.
  Future<Review?> getReview(int applyId);
  Future<int> addReview(Review review);

  /// Generates an auth token for the given user id.
  ///
  /// In case of an existing token, the token will be overwritten.
  Future<String> generateToken(int userId);

  /// Returns the email address associated with the given token.
  ///
  /// If the token is not found, `null` is returned.
  Future<String?> getEmailToken(String email);

  /// Generates a token for the given email address.
  ///
  /// In case of an existing token, the token will be overwritten.
  Future<String> generateEmailToken(String email);
}
