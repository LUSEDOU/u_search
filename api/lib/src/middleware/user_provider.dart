import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:logging/logging.dart';
import 'package:u_search_api/api.dart';

Middleware get userProvider => bearerAuthentication<User>(
      authenticator: (context, token) async {
        Logger('UserProvider').info('Verifying token: $token');
        if (token case 'pe.edu.usil.usearch' || 'pe.edu.usil.usearch.dev') {
          return User.anonymous;
        }

        final dataSource = context.read<DataSource>();
        return dataSource.getUserByToken(token);
      },
    );

Future<User?> _verifyToken(String token, RequestContext context) async {
  Logger('UserProvider').info('Verifying token: $token');
  if (token case 'pe.edu.usil.usearch' || 'pe.edu.usil.usearch.dev') {
    return User.anonymous;
  }

  final dataSource = context.read<DataSource>();
  return dataSource.getUserByToken(token);
}
