import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/features/user/presentation/widgets/signup_form.dart';

@RoutePage()
class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: const Color.fromARGB(255, 229, 237, 243),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Create your Account!",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 4, 175),
                  ),
                ),
                SizedBox(height: 20),
                SignupForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
