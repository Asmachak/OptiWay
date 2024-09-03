import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/features/user/presentation/widgets/signup_form.dart';

@RoutePage()
class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen's height
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            height:
                screenHeight, // Ensures the container height matches the screen height
            child: Container(
              color: const Color.fromARGB(255, 229, 237, 243),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Create your Account!",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 4, 175),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    "assets/optiway.png",
                    width: screenWidth * 0.5,
                  ),
                  const SizedBox(height: 20),
                  const SignupForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
