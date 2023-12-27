// ignore_for_file: prefer_const_constructors
import 'package:storage/storage.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

// Storage is exported and can be implemented
class FakeStorage extends Fake implements Storage {}

void main() {
  group('Storage', () {
    test('can be implemented', () {
      expect(FakeStorage.new, returnsNormally);
    });
    test('exports StorageException', () {
      expect(
        () => StorageException('oops'),
        returnsNormally,
      );
    });
  });
}
