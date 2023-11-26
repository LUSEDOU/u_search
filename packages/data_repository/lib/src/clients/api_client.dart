import 'package:data_repository/data_repository.dart';

abstract class ApiClient {
  Future<List<Contest>> getContests();

  Stream<List<Apply>> getApplies();
}
