import 'package:u_search_flutter/app/app.dart';
import 'package:u_search_flutter/main/bootstrap/bootstrap.dart';

void main() {
  bootstrap(
    (
      sharedPreferences,
    ) async {
      // await Firebase.initializeApp(
      //   options: DefaultFirebaseOptions.currentPlatform,
      // );

      // const packageInfoClient = PackageInfoClient(
      //   appName: 'U Search [DEV]',
      //   packageName: 'com.example.u_search_flutter',
      //   packageVersion: '0.2.1',
      // );
      //
      // final persistentStorage = PersistentStorage(
      //   sharedPreferences: sharedPreferences,
      // );
      //
      // final userRepository = UserRepository(
      //   storage: UserStorage(
      //     storage: persistentStorage,
      //   ),
      //   authenticationClient: FirebaseAuthenticationClient(),
      //   packageInfoClient: packageInfoClient,
      // );

      return const App(
          // userRepository: userRepository,
          );
    },
  );
}
