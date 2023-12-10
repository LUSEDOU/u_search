import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/bootstrap.dart';
import 'package:u_search_flutter/clients.dart';
import 'package:u_search_flutter/observer.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();

  final authClient = AuthClientTest();
  final cacheClient = CacheClientTest();
  final apiClient = ApiClientTest();

  bootstrap(
    authClient: authClient,
    cacheClient: cacheClient,
    userCacheKey: '',
    apiClient: apiClient,
  );
}
