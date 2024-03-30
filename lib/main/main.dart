import 'package:u_search_flutter/app/app.dart';
import 'package:u_search_flutter/main/bootstrap/bootstrap.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap(() async {
    final userRepository = UserRepository(
      storage: UserStorage(storage: storage),
      authenticationClient: null,
    );

    return App(
      authenticationRepository: authenticationRepository,
      dataRepository: dataRepository,
    );
  });
}
