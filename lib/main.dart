import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/bootstrap.dart';
import 'package:u_search_flutter/clients.dart';
import 'package:u_search_flutter/keys.dart';
import 'package:u_search_flutter/observer.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();

  final authClient = AuthClientTest();
  final cacheClient = CacheClientTest();
  final apiClient = ApiClientTest();
  final keys = CacheKeys();

  bootstrap(
    authClient: authClient,
    cacheClient: cacheClient,
    apiClient: apiClient,
    dataKeys: keys.data,
    authKeys: keys.auth,
  );
}
