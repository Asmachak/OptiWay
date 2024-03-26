import 'package:flutter/material.dart';
import 'package:front/features/user/presentation/pages/login_screen.dart';
import 'package:front/features/user/presentation/pages/signup.dart';
import 'package:auto_route/auto_route.dart';
import 'package:front/routes/app_routes.gr.dart';

class WelcomeButton extends StatelessWidget {
  final String buttonText;

  const WelcomeButton({Key? key, required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 30,
      child: OutlinedButton(
        onPressed: () {
          if (buttonText.toLowerCase() == "login") {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => const LoginScreen()),
            // );
            AutoRouter.of(context).navigate(const LoginRoute());
          } else if (buttonText.toLowerCase() == "signup") {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => const SignupScreen()),
            // );
            AutoRouter.of(context).navigate(const SignupRoute());
          }
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 67, 70, 225),
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          side: const BorderSide(color: Color.fromARGB(255, 67, 70, 225)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
