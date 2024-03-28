import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/presentation/blocs/splash_provider.dart';
import 'package:front/features/user/presentation/pages/login_screen.dart';
import 'package:front/features/user/presentation/pages/welcome_screen.dart';
import 'package:front/routes/app_routes.gr.dart';

@RoutePage()
class SplashScreen extends ConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLoginStatus = ref.watch(userLoginCheckProvider);

    userLoginStatus.when(
      data: (isLoggedIn) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (isLoggedIn) {
            AutoRouter.of(context).replace(const HomeRoute());
          } else {
            AutoRouter.of(context).replace(LoginRoute());
          }
        });
      },
      loading: () {
        // Show loading indicator if needed
        return Scaffold(
          backgroundColor: Colors.amber,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      error: (error, stackTrace) {
        // Handle error if needed
        return Scaffold(
          backgroundColor: Colors.amber,
          body: Center(
            child: Text('Error: $error'),
          ),
        );
      },
    );

    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Image.asset(
          'assets/images/splash.svg',
          width: 200,
          height: 43,
        ),
      ),
    );
  }
}
