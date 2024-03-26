import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthLocalDataSource _hiveBox = AuthLocalDataSource();

  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Call logout asynchronously
                await GetIt.instance.get<AuthLocalDataSource>().logout();
                // Navigate to welcomeScreen after logout
                AutoRouter.of(context).navigate(const WelcomeRoute());
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> test() async {
    // Changed return type to Future<String>
    try {
      String tet = GetIt.instance.get<AuthLocalDataSource>().currentUser!.name;
      if (tet != null) {
        print('tet is here');
        print(_hiveBox.currentUser);
      }
      print('tet is not here');
      return tet; // Return the result as a String
    } catch (e) {
      print('Error during login performance: $e');
      throw e;
    }
  }
}
