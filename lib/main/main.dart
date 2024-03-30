import 'package:firebase_authentication_client/firebase_authentication_client.dart';
import 'package:persistent_storage/persistent_storage.dart';
import 'package:u_search_flutter/app/app.dart';
import 'package:u_search_flutter/main/bootstrap/bootstrap.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap(
    (
      sharedPreferences,
    ) async {
      final persistentStorage = PersistentStorage(
        sharedPreferences: sharedPreferences,
      );

      final userRepository = UserRepository(
        storage: UserStorage(
          storage: persistentStorage,
        ),
        authenticationClient: const FirebaseAuthenticationClient(),
      );

      return App(
        authenticationRepository: authenticationRepository,
        dataRepository: dataRepository,
      );
    },
  );
}
