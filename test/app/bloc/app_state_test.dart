import 'package:cache_client/cache_client.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:u_search_flutter/app/app.dart';

class MockDataRepository extends Mock implements DataRepository {}

class MockCacheClient extends Mock implements CacheClient {}

class MockApiClient extends Mock implements ApiClient {}

class MockCacheKeys extends Mock implements DataCacheKeys {
  @override
  String get roleCacheKey => 'role';
}

class FakeRole extends Fake implements Role {}

void main() {
  late DataRepository dataRepository;
  late CacheClient cache;
  late ApiClient client;
  final DataCacheKeys cacheKeys = MockCacheKeys();

  group('AppState', () {});

  group('AppStateX', () {
    setUpAll(() {
      registerFallbackValue(FakeRole());
    });

    setUp(() {
      client = MockApiClient();
      cache = MockCacheClient();

      dataRepository = DataRepository(
        client: client,
        cache: cache,
        cacheKeys: cacheKeys,
      );
    });

    group('getRole', () {
      test('returns correct Role', () {
        const role = Admin.empty;
        const appState = AppState.authenticated(role: role);

        expect(appState.getRole<Admin>(), isA<Admin>());
      });

      test('throws AssertionEror if Role is not that role ', () {
        const role = Admin.empty;
        const appState = AppState.authenticated(role: role);

        expect(() => appState.getRole<Researcher>(), throwsException);
      });

      test('throws AssertionError if Role is not that role ', () {
        const role = Role(
          id: 1,
          type: RoleType.researcher,
        );
        const appState = AppState.authenticated(role: role);

        expect(() => appState.getRole<Admin>(), throwsException);
      });
    });
  });
}
