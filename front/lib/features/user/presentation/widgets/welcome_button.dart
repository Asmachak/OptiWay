import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:front/routes/app_routes.gr.dart';

class WelcomeButton extends StatelessWidget {
  final String buttonText;

  const WelcomeButton({Key? key, required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen's width
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.7, // 80% of the screen's width
      height: screenWidth *
          0.10, // Height relative to the width (to keep a good aspect ratio)
      child: OutlinedButton(
        onPressed: () {
          _handleButtonPress(context);
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 67, 70, 225),
          foregroundColor: Colors.white,
          side: const BorderSide(color: Color.fromARGB(255, 67, 70, 225)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: screenWidth * 0.045, // Font size relative to screen width
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _handleButtonPress(BuildContext context) {
    switch (buttonText.toLowerCase()) {
      case 'login':
        AutoRouter.of(context).push(const LoginRoute());
        break;
      case 'signup':
        AutoRouter.of(context).push(const SignupRoute());
        break;
      case 'login as organiser':
        AutoRouter.of(context).push(const OrganiserLoginRoute());
        break;
      case 'signup as organiser':
        AutoRouter.of(context).push(const OrganiserSignupRoute());
        break;
      default:
        // Handle other cases or show a default action
        break;
    }
  }
}
