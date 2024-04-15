import 'package:application_repository/application_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockApplicationStorage extends Mock implements ApplicationStorage {}

void main() {
  group('ApplicationRepository', () {
    late ApplicationStorage storage;
    late ApplicationRepository {name.camelCase()}Repository;

    setUp(() {
      storage = MockApplicationStorage();

      applicationRepository = ApplicationRepository(
        storage: storage,
      );
    });
  });
}
