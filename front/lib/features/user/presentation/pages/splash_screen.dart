import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/presentation/blocs/splash_provider.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class SplashScreen extends ConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLoginStatus = ref.watch(userLoginCheckProvider);

    userLoginStatus.when(
      data: (isLoggedIn) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Delay execution by 3 seconds using Future.delayed
          Future.delayed(const Duration(seconds: 3), () {
            if (isLoggedIn) {
              AutoRouter.of(context).replace(const MainRoute());
            } else {
              AutoRouter.of(context).replace(const WelcomeRoute());
            }
          });
        });
      },
      loading: () {
        // Show loading indicator if needed
        return Scaffold(
          body: Center(
            child: _buildUI(),
          ),
        );
      },
      error: (error, stackTrace) {
        // Handle error if needed
        return Scaffold(
          body: Center(
            child: Text('Error: $error'),
          ),
        );
      },
    );

    return Scaffold(
      body: Center(
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/animations/spalsh.json"),
          const SizedBox(
              height:
                  20), // Add some space between the Lottie animation and the text
          const Text(
            "OptiWay",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.indigo),
          ),
        ],
      ),
    );
  }
}
