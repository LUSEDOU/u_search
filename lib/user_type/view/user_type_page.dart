import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_flutter/app/app.dart';

class UserTypePage extends StatelessWidget {
  const UserTypePage({
    required this.appBloc,
    super.key,
  });

  final AppBloc appBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: appBloc,
      child: const UserTypeView(),
    );
  }
}

class UserTypeView extends StatelessWidget {
  const UserTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: CupertinoScrollbar(
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Select your account type',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    for (final userType in UserType.permitted)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _UserTypeButton(
                            userType: userType,
                          ),
                        ),
                      ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       maximumSize: Size(
                    //         size.width * 0.5,
                    //         100,
                    //       ),
                    //       minimumSize: Size(
                    //         size.width * 0.5,
                    //         100,
                    //       ),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(8.0),
                    //       ),
                    //       padding: const EdgeInsets.all(16.0),
                    //       backgroundColor: state.type == userType
                    //           ? theme.colorScheme.primary.withOpacity(0.1)
                    //           : null,
                    //     ),
                    //     onPressed: () {
                    //       context.read<AppBloc>().add(
                    //             AppUserTypeChanged(userType),
                    //           );
                    //       context.go('/login');
                    //     },
                    //     child: Text(
                    //       userType.toString(),
                    //       style: TextStyle(
                    //         color: state.type == userType
                    //             ? theme.colorScheme.primary
                    //             : theme.colorScheme.onSurface,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _UserTypeButton extends StatelessWidget {
  const _UserTypeButton({
    required this.userType,
  });

  final UserType userType;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.3,
      height: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.all(16.0),
        ),
        onPressed: () {
          context.read<AppBloc>().add(
                AppUserTypeChanged(userType),
              );
          context.go('/login');
        },
        child: Text(
          userType.name,
          style: const TextStyle(
            fontSize: 40.0,
          ),
        ),
      ),
    );
  }
}
