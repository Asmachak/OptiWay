import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget loadingWidget() {
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      color: Colors.white, // Set the background color using decoration
      image: DecorationImage(
        image: AssetImage("assets/optiway.png"),
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
              height:
                  200), // Add some space between the Lottie animation and the top edge
          Lottie.asset("assets/animations/load.json"),
        ],
      ),
    ),
  );
}
