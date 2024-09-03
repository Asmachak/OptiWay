import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/features/organiser/presentation/widgets/organiser_signup_form.dart';

@RoutePage()
class OrganiserSignupScreen extends StatelessWidget {
  const OrganiserSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen's height
    final double screenHeight = MediaQuery.of(context).size.height;

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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create your Organiser Account!",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 4, 175),
                    ),
                  ),
                  SizedBox(height: 20),
                  OrganiserSignupForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
