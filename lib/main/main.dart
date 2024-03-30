import 'package:firebase_authentication_client/firebase_authentication_client.dart';
import 'package:package_info_client/package_info_client.dart';
import 'package:persistent_storage/persistent_storage.dart';
import 'package:u_search_flutter/app/app.dart';
import 'package:u_search_flutter/main/bootstrap/bootstrap.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap(
    (
      sharedPreferences,
    ) async {
      const packageInfoClient = PackageInfoClient(
        appName: 'U Search [DEV]',
        packageName: 'com.example.u_search_flutter',
        packageVersion: '0.2.1',
      );

      final persistentStorage = PersistentStorage(
        sharedPreferences: sharedPreferences,
      );

      final userRepository = UserRepository(
        storage: UserStorage(
          storage: persistentStorage,
        ),
        authenticationClient: FirebaseAuthenticationClient(),
        packageInfoClient: packageInfoClient,
      );

      return App(
        userRepository: userRepository,
      );
    },
  );
}
