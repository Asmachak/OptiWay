import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class parkingsScreen extends StatelessWidget {
  const parkingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("this is parkings screen"),
    );
  }
}
