import 'package:user_repository/user_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockUserStorage extends Mock implements UserStorage {}

void main() {
  group('UserRepository', () {
    late UserStorage storage;
    late UserRepository {name.camelCase()}Repository;

    setUp(() {
      storage = MockUserStorage();

      userRepository = UserRepository(
        storage: storage,
      );
    });
  });
}
