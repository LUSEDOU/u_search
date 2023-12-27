import 'dart:io';

import 'package:data_repository/data_repository.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_api_client/src/helper/json_helper.dart';

/// {@template supabase_client}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class SupabaseApi extends ApiClient {
  /// {@macro supabase_client}
  SupabaseApi({
    required String url,
    required String anonKey,
  })  : _client = SupabaseClient(url, anonKey),
        super();

  /// The [SupabaseClient] used to interact with the Supabase API.
  final SupabaseClient _client;

  @override
  Future<Apply> addApply(Apply apply) async {
    final json = JsonHelper.format(apply.toJson());
    final response =
        await _client.from('applies').insert(json).select().single();

    return getApply(response['id'] as int);
  }

  @override
  Future<Apply> getApply(int id) async {
    final response =
        await _client.from('applies').select().eq('id', id).single();

    final applyJson = <String, dynamic>{...response};
    final contest = await getContest(applyJson['contest_id'] as int);
  }

  @override
  Future<Research> addResearch(Research research) {
    // TODO: implement addResearch
    throw UnimplementedError();
  }

  @override
  Future<Review> addReview(Review review) {
    // TODO: implement addReview
    throw UnimplementedError();
  }

  @override
  Future<Role> addRoleToUser(Role role, {required User user}) {
    // TODO: implement addRoleToUser
    throw UnimplementedError();
  }

  @override
  Future<User> addUser(User user) {
    // TODO: implement addUser
    throw UnimplementedError();
  }

  @override
  Future<Stream<List<Apply>>> getApplies({required Role role}) {
    // TODO: implement getApplies
    throw UnimplementedError();
  }

  @override
  Future<List<Contest>> getContests() {
    // TODO: implement getContests
    throw UnimplementedError();
  }

  Future<Contest> getContest(int id) {
      final response =
        await _client.from('contests').select().eq('id', id).single();

    final contestJson = <String, dynamic>{...response};
    final Criterias = await getCriterias(contestJson['id'] as int);
  }

  Future<List<Criteria>> getCriterias(int contestId) async {
      final response =
        await _client.from('criterias').select().eq('contest_id', contestId);

    final criteriasJson = <String, dynamic>{...response};
    final criterias = await getCriterias(criteriasJson['id'] as int);
  }

  @override
  Future<List<Role>> getEvaluators() {
    // TODO: implement getEvaluators
    throw UnimplementedError();
  }

  @override
  void logout() {
    // TODO: implement logout
  }

  @override
  Stream<Role?> roleChanges() {
    // TODO: implement roleChanges
    throw UnimplementedError();
  }

  @override
  Future<Apply> updateApply(Apply apply) {
    // TODO: implement updateApply
    throw UnimplementedError();
  }

  @override
  Role updateRole(Role role) {
    // TODO: implement updateRole
    throw UnimplementedError();
  }

  @override
  Future<String> uploadResearchFile({required File research}) {
    // TODO: implement uploadResearchFile
    throw UnimplementedError();
  }

  @override
  Future<User> upsertUser(User user) {
    // TODO: implement upsertUser
    throw UnimplementedError();
  }

  @override
  Future<bool> validateCode(String code, int type) {
    // TODO: implement validateCode
    throw UnimplementedError();
  }
}
