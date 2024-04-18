import 'package:collection/collection.dart';
import 'package:u_search_api/api.dart';

part 'static_data.dart';

class InMemoryDataSource implements DataSource {
  @override
  Future<List<Apply>> getApplications() async => _applications;

  @override
  Future<Apply?> getApplication(int id) async {
    return _applications.firstWhereOrNull((element) => element.id == id);
  }

  @override
  Future<List<User>> getReviewers() async => _users.take(2).toList();
}
