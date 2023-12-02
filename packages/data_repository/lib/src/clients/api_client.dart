import 'dart:io';

import 'package:data_repository/data_repository.dart';

abstract class ApiClient {
  Future<List<Contest>> getContests();

  Stream<List<Apply>> getApplies();

  Future<String> uploadResearch({
    required int applicantId,
    required File research,
  });

  Future<Apply> getApply(int id);
}
