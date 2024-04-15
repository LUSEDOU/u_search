import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/auth/auth.dart';
import 'package:user_repository/user_repository.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key, this.token});

  factory AuthPage.routeBuilder(_, GoRouterState state) {
    final data = state.extra as AuthPageData?;

    return AuthPage(
      key: const Key('auth'),
      token: data?.token,
    );
  }

  final String? token;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final userRepository = context.read<UserRepository>();
        return AuthBloc(
          userRepository: userRepository,
        )..add(AuthRequested(token));
      },
      child: const AuthView(),
    );
  }
}

class AuthPageData extends Equatable {
  const AuthPageData({
    this.token,
  });

  final String? token;

  @override
  List<Object?> get props => [token];
}
