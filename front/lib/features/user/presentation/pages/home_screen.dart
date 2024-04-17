import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("this is main screen"),
    );
  }
}
