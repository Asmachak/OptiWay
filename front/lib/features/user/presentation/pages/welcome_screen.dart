import 'package:flutter/material.dart';
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
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 50.0),
                    child: Text(
                      "OptiWay",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4446e9),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                    height:
                        16), // Add some space between the text and the image
                Center(
                  child: Image.asset(
                    "assets/welcome1.png",
                    width: screenWidth * 0.8,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Welcome !",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 4, 175),
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    "Simplifying your journey from parking to event participation.",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 4, 175),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                const WelcomeButton(buttonText: "Login"),
                const SizedBox(height: 10),
                const WelcomeButton(buttonText: "Signup"),
                const SizedBox(height: 20),
                const Text(
                  "Or via Social media",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 4, 175),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 60, 123, 175),
                      child: IconButton(
                          icon: const Icon(Icons.facebook),
                          color: Colors.white,
                          onPressed: () {}),
                    ),
                    const SizedBox(
                        width: 20), // Adjust spacing between buttons as needed
                    CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 156, 72, 66),
                      child: IconButton(
                        icon: const Icon(Icons.mail),
                        color: Colors.white,
                        onPressed: () {
                          // Handle Gmail button press
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
