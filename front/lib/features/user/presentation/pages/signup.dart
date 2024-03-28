import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/features/user/presentation/widgets/signup_form.dart';

@RoutePage()
class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              color: const Color.fromARGB(255, 229, 237, 243),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 18.0, 0, 18),
                    child: Text(
                      "Creat your Account !",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 4, 175),
                      ),
                    ),
                  ),
                  SignupForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
