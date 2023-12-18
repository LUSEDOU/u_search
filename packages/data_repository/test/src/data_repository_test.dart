// ignore_for_file: prefer_const_constructors
import 'package:cache_client/cache_client.dart';
import 'package:data_repository/data_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockCacheClient extends Mock implements CacheClient {}

class MockCacheKeys extends Mock implements DataCacheKeys {
  @override
  String get roleCacheKey => 'role';
}

void main() {
  group('DataRepository', () {
    late ApiClient client;
    late CacheClient cache;
    late DataCacheKeys cacheKeys;
    late DataRepository dataRepository;

    setUp(() {
      client = MockApiClient();
      cache = MockCacheClient();
      cacheKeys = MockCacheKeys();
      dataRepository = DataRepository(
        client: client,
        cache: cache,
        cacheKeys: cacheKeys,
      );
    });

    test('can be instantiated', () {
      expect(
        DataRepository(
          client: client,
          cache: cache,
          cacheKeys: cacheKeys,
        ),
        isNotNull,
      );
    });

    group('currentRole', () {
      test('returns correct Role', () {
        when(() => cache.read<Role>(key: cacheKeys.roleCacheKey))
            .thenReturn(Role.empty);

        final role = dataRepository.currentRole;

        verify(() => cache.read<Role>(key: cacheKeys.roleCacheKey)).called(1);

        expect(role, isA<Role>());
      });

      test('returns Unknown by default', () {
        when(() => cache.read<Role>(key: cacheKeys.roleCacheKey))
            .thenReturn(null);

        final role = dataRepository.currentRole;

        verify(() => cache.read<Role>(key: cacheKeys.roleCacheKey)).called(1);

        expect(role, isA<Unknown>());
      });

      test('returns the correct Role by the roleType', () {
        when(() => cache.read<Role>(key: cacheKeys.roleCacheKey))
            .thenReturn(Role(id: 1, type: RoleType.researcher));

        final role = dataRepository.currentRole;

        verify(() => cache.read<Role>(key: cacheKeys.roleCacheKey)).called(1);

        expect(role, isA<Researcher>());
      });
    });
  });
}
