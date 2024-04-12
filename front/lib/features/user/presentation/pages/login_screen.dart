import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/presentation/widgets/login_form.dart';

@RoutePage()
class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextStyle titleStyle = const TextStyle(
      fontStyle: FontStyle.italic,
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 1, 4, 175),
    );

    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 229, 237, 243), // Set background color here
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Text(
                    "welcome back !!",
                    style: titleStyle,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 18.0, 0, 18),
                  child: Text(
                    "Login to begin the adventure !",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 4, 175),
                    ),
                  ),
                ),
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
