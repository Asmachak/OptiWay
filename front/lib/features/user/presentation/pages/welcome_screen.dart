import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:front/features/admin/presentation/pages/login_admin.dart';
import 'package:front/features/user/presentation/widgets/welcome_button.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: const Color.fromARGB(255, 229, 237, 243),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "OptiWay",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4446e9),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Image.asset(
                    "assets/welcome1.png",
                    width:
                        screenWidth * 0.7, // Smaller image for better balance
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Welcome!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 4, 175),
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Simplifying your journey from parking to event participation.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(
                          0xFF4446e9), // Matched text color to the title color
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                const WelcomeButton(buttonText: "Login"),
                const SizedBox(height: 16),
                const WelcomeButton(buttonText: "Signup"),
                const SizedBox(height: 10),

                const Text(
                  "Or via Social Media",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 4, 175),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialMediaButton(
                      icon: Icons.facebook,
                      color: const Color(0xFF3b5998),
                      onPressed: () {
                        // Handle Facebook login
                      },
                    ),
                    const SizedBox(width: 20),
                    SocialMediaButton(
                      icon: Icons.mail,
                      color: const Color(0xFFEA4335),
                      onPressed: () {
                        // Handle Google login
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Organizer Section
                const Divider(thickness: 1, color: Colors.grey),
                const SizedBox(height: 16),
                const Text(
                  "Are you an Organizer?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 4, 175),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    const WelcomeButton(buttonText: "Login as Organiser"),
                    const SizedBox(height: 16),
                    const WelcomeButton(buttonText: "signup as Organiser"),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        text: 'I am an administrator .. ',
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: const TextStyle(
                              color: Colors.indigo,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AdminLoginScreen()),
                                );
                              },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom SocialMediaButton Widget
class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const SocialMediaButton({
    Key? key,
    required this.icon,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 24,
      child: IconButton(
        icon: Icon(icon),
        color: Colors.white,
        onPressed: onPressed,
      ),
    );
  }
}
