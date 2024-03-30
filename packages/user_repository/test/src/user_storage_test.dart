import 'package:user_repository/user_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:storage/storage.dart';
import 'package:test/test.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  group('UserStorage', () {
    late Storage storage;

    setUp(() {
      storage = MockStorage();

      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});
    });
  });
}
