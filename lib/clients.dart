import 'package:u_search_api/u_search_api.dart';
import 'package:u_search_flutter/factory.dart';

class DataRepository {
  const DataRepository();
  //
  // Future<List<Apply>> getApplies() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   return appliesListFactory(10);
  // }

  Stream<List<Apply>> getApplies() async* {
    await Future.delayed(const Duration(seconds: 2));
    yield appliesListFactory(10);
  }
}

class AuthenticatedRepository {
  const AuthenticatedRepository();

  Stream<User> getUser() async* {
    await Future.delayed(const Duration(seconds: 2));
    yield userFactory();
  }
}
