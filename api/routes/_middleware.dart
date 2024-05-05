import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:email_service/email_service.dart';
import 'package:logging/logging.dart';
import 'package:u_search_api/api.dart';
import '../headers/headers.dart';
import '../main.dart';

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(
        bearerAuthentication<User>(
          authenticator: (context, token) async {
            Logger('UserProvider').info('Attempt to auth: $token');
            if (token
                case 'pe.edu.usil.u_search_flutter.dev' ||
                    'pe.edu.usil.u_search_flutter') {
              Logger('UserProvider').info('Anonymous user');
              return User.anonymous;
            }

            final user = await context.read<DataSource>().getUserByToken(token);
            Logger('UserProvider').info('User: $user');
            return user;
          },
        ),
      )
      .use(provider<DataSource>((_) => dataSource))
      .use(provider<EmailService>((_) => emailService))
      .use(provider<Logger>((_) => Logger.root))
      .use(corsHeaders())
      .use(contentTypeHeader());
}
