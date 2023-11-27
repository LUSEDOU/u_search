import 'dart:async';
import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart'
    as auth;
import 'package:data_repository/data_repository.dart';
import 'package:u_search_flutter/factory.dart';

class AuthClientTest implements auth.AuthClient {
  AuthClientTest() : super();

  final StreamController<auth.User?> _userController =
      StreamController<auth.User?>();

  @override
  Stream<auth.User?> authStateChanges() {
    return _userController.stream;
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _userController.add(
      auth.User(id: '123', email: email),
    );
  }

  @override
  Future<void> logIn({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _userController.add(
      auth.User(id: '123', email: email),
    );
  }

  @override
  Future<void> logOut() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _userController.add(null);
  }
}

class CacheClientTest implements auth.CacheClient {
  @override
  T? read<T>({required String key}) {
    return null;
  }

  @override
  void write<T>({required String key, required T value}) {
    return;
  }
}

class ApiClientTest implements ApiClient {
  final StreamController<List<Apply>> _applyController =
      StreamController<List<Apply>>();

  @override
  Stream<List<Apply>> getApplies() async* {
    await Future.delayed(const Duration(milliseconds: 100));
    _applyController.add(
      appliesListFactory(4),
    );
    yield* _applyController.stream;
  }

  @override
  Future<List<Contest>> getContests() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return contestsListFactory(4);
  }

  @override
  Future<String> uploadResearch({
    required int applicantId,
    required File research,
  }) {
    return Future.delayed(
      const Duration(milliseconds: 100),
      () => 'url',
    );
  }
}
