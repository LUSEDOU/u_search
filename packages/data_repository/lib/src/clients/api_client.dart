import 'dart:io';

import 'package:data_repository/data_repository.dart';

abstract class ApiClient {
  Future<List<Contest>> getContests();

  Future<Stream<List<Apply>>> getApplies();

  Future<Apply> getApply(int id);

  Future<String> uploadResearchFile({
    required File research,
  });

  Future<Research> addResearch(Research research);

  Future<Apply> addApply(Apply apply);
}
