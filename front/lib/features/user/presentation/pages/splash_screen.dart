import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:lottie/lottie.dart';
import 'package:front/features/organiser/presentation/blocs/splash_provider.dart';
import 'package:front/features/user/presentation/blocs/splash_provider.dart';

final initializationProvider = FutureProvider<void>((ref) async {
  // Check if the user is logged in
  final isUserLoggedIn = await ref.read(userLoginCheckProvider.future);

  // Check if the organiser is logged in
  final isOrganiserLoggedIn =
      await ref.read(organiserLoginCheckProvider.future);

  // Save the login status in the provider
  ref.read(userOrOrganiserLoginProvider.notifier).state =
      isUserLoggedIn ? 'user' : (isOrganiserLoggedIn ? 'organiser' : null);
});

final userOrOrganiserLoginProvider = StateProvider<String?>((ref) => null);

@RoutePage()
class SplashScreen extends ConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialization = ref.watch(initializationProvider);

    return initialization.when(
      data: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Delay execution by 3 seconds using Future.delayed
          Future.delayed(const Duration(seconds: 3), () {
            final loginType = ref.read(userOrOrganiserLoginProvider);

            if (loginType == 'user') {
              AutoRouter.of(context).replace(const MainRoute());
            } else if (loginType == 'organiser') {
              AutoRouter.of(context).replace(const MainOrganiserRoute());
            } else {
              AutoRouter.of(context).replace(const WelcomeRoute());
            }
          });
        });
        return Scaffold(
          body: Center(
            child: _buildUI(),
          ),
        ); // Keep showing splash screen UI during the delay
      },
      loading: () => _buildUI(), // Show splash screen UI while loading
      error: (error, stackTrace) {
        // Handle error if needed
        return Scaffold(
          body: Center(
            child: Text('Error: $error'),
          ),
        );
      },
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
