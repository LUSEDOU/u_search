import 'dart:async';
import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart'
    as auth;
import 'package:data_repository/data_repository.dart';
import 'package:rxdart/rxdart.dart';
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
    return const auth.User(id: '123', email: 'test@test.com') as T;
    // return null;
  }

  @override
  void write<T>({required String key, required T value}) {
    return;
  }
}

class ApiClientTest implements ApiClient {
  final _applyController = BehaviorSubject<List<Apply>>.seeded(
    appliesListFactory(5),
  );

  @override
  Future<Stream<List<Apply>>> getApplies() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _applyController.stream;
  }

  @override
  Future<List<Contest>> getContests() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return contestsListFactory(4);
  }

  @override
  Future<String> uploadResearchFile({
    required File research,
  }) {
    return Future.delayed(
      const Duration(milliseconds: 100),
      () => '123',
    );
  }

  @override
  Future<Apply> getApply(int id) {
    return Future.delayed(
      const Duration(milliseconds: 100),
      () => _applyController.value.firstWhere((apply) => apply.id == id),
    );
  }

  @override
  Future<Research> addResearch(Research research) {
    return Future.delayed(
        const Duration(milliseconds: 100), () => research.copyWith());
  }

  @override
  Future<Apply> addApply(Apply apply) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final applies = [..._applyController.value];
    final newApply = apply.copyWith(id: applies.length + 1);
    _applyController.add(applies..add(newApply));
    return newApply;
  }

  @override
  Future<Review> addReview(Review review) {
    final newReview = review.copyWith(
      id: review.apply!.id,
    );
    final newApply = review.apply!.copyWith(
      review: newReview,
    );
    final applies = [..._applyController.value];
    _applyController.add(
      applies
        ..removeWhere((element) => element.id == newApply.id)
        ..add(newApply),
    );
    return Future.delayed(
      const Duration(milliseconds: 100),
      () => newReview,
    );
  }
}
