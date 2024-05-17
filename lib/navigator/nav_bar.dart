import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/gen/assets.gen.dart';
import 'package:user_repository/user_repository.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    required this.body,
    this.canGoBack = false,
    super.key,
  });

  final Widget body;
  final bool canGoBack;

  Widget _tabButton(String text, IconData icon, {VoidCallback? onPressed}) {
    return Expanded(
      child: AppButton.darkAqua(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(width: AppSpacing.sm),
            Text(text),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.darkAqua,
        leading: canGoBack
            ? AppBackButton.light(
                onPressed: context.pop,
              )
            : null,
        title: Padding(
          padding: const EdgeInsets.only(right: AppSpacing.xlg),
          child: Row(
            children: [
              Assets.images.logo.image(
                height: 50,
                fit: BoxFit.contain,
              ),
              _tabButton(
                'Home',
                Icons.home,
                onPressed: () => context.go('/'),
              ),
              _tabButton(
                'Applies',
                Icons.assignment,
                onPressed: () => context.go('/applies'),
              ),
              _tabButton(
                'Contests',
                Icons.emoji_events,
                onPressed: () => context.go('/contests'),
              ),
              _tabButton(
                'Profile',
                Icons.person,
                onPressed: () => context.go('/profile'),
              ),
              _tabButton(
                'Logout',
                Icons.logout,
                onPressed: () async {
                  await context.read<UserRepository>().logOut();
                  if (context.mounted) context.go('/login');
                },
              ),
            ],
          ),
        ),
      ),
      body: body,
    );
  }
}
