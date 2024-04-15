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
      const packageInfoClient = PackageInfoClient(
        appName: 'U Search [DEV]',
        packageName: 'pe.edu.usil.u_search_flutter.dev',
        packageVersion: '0.2.1',
      );

      final tokenStorage = CacheTokenStorage(
        anonymousToken: packageInfoClient.packageName,
        preferences: sharedPreferences,
      );

      final userRepository = UserRepository(
        tokenStorage: tokenStorage,
        apiClient: USearchApiClient.localhost(
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
