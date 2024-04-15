import 'package:package_info_client/package_info_client.dart';
import 'package:token_storage/token_storage.dart';
import 'package:u_search_api/client.dart';
import 'package:u_search_flutter/app/app.dart';
import 'package:u_search_flutter/main/bootstrap/bootstrap.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap(
    (
      sharedPreferences,
    ) async {
      // await Firebase.initializeApp(
      //   options: DefaultFirebaseOptions.currentPlatform,
      // );
      const packageInfoClient = PackageInfoClient(
        appName: 'U Search',
        packageName: 'pe.edu.usil.u_search_flutter',
        packageVersion: '0.2.1',
      );

      final tokenStorage = CacheTokenStorage(
        preferences: sharedPreferences,
        anonymousToken: packageInfoClient.packageName,
      );

      final userRepository = UserRepository(
        tokenStorage: tokenStorage,
        apiClient: USearchApiClient(
          tokenProvider: tokenStorage.readToken,
        ),
      );

      return App(
        userRepository: userRepository,
        user: await userRepository.user.first,
      );
    },
  );
}
