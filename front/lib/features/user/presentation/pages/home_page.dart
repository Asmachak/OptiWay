import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/user/presentation/blocs/auth_providers.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<String>(
              future: test(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(snapshot.data ?? '');
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Call logout asynchronously
                ref.read(authNotifierProvider.notifier).logout();
                // Navigate to WelcomeRoute after logout
                AutoRouter.of(context).replace(const WelcomeRoute());
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> test() async {
    try {
      String tet = GetIt.instance.get<AuthLocalDataSource>().currentUser!.name!;
      print("tet");
      print(tet);
      if (tet != null) {
        print('tet is here');
        return tet;
      }
      print('tet is not here');
      tet = "hi ! ";
      return tet; // Return the result as a String
    } catch (e) {
      print('Error during login performance: $e');
      throw e;
    }
  }
}
