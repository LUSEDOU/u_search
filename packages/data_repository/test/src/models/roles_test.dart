import 'package:data_repository/src/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('Roles', () {
    group('Admin', () {
      group('toJson', () {
        test('returns correct json', () {
          const admin = Admin(id: 1);
          final json = admin.toJson();

          expect(json['id'], 1);
          expect(json['type'], 2);
          expect(json['user'], User.empty.toJson());
        });
      });

      group('fromJson', () {
        test('returns correct Admin', () {
          final json = {
            'id': 1,
            'type': 2,
            'user': User.empty.toJson(),
          };
          final admin = Admin.fromJson(json);
          expect(admin.id, 1);
          expect(admin.type, RoleType.admin);
          expect(admin.user, User.empty);
        });

        test('throws ArgumentError when type is not admin', () {
          final json = {
            'id': 1,
            'type': 1,
            'user': User.empty.toJson(),
          };
          expect(
            () => Admin.fromJson(json),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.message,
                'message',
                'Role type must be admin',
              ),
            ),
          );
        });

        test('Same as toJson', () {
          const admin = Admin(id: 1);

          expect(admin, Admin.fromJson(admin.toJson()));
        });
      });
    });
  });
}
