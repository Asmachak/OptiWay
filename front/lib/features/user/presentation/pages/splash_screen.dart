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

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlutterLogo(size: 100),
            const SizedBox(height: 20),
            const Text(
              'Welcome to MyApp',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildLoginStatusWidget(userLoginStatus, context),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginStatusWidget(
      AsyncValue<bool> userLoginStatus, BuildContext context) {
    return userLoginStatus.when(
      data: (isLoggedIn) {
        Future.delayed(const Duration(seconds: 2), () {
          if (isLoggedIn) {
            // Navigate to WelcomeScreen if logged in
            context.router.replace(const HomeRoute());
            print("User is logged in. Navigating to Home.");
          } else {
            // Navigate to WelcomeRoute if not logged in
            context.router.replace(const WelcomeRoute());
            print("User is not logged in. Navigating to WelcomeRoute.");
          }
        });
        return const CircularProgressIndicator();
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) {
        // Handle error appropriately, e.g., show error message
        return Text('Error: $error');
      },
    );
  }
}
