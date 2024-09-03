import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OrganiserStatistqueScreen extends StatefulWidget {
  const OrganiserStatistqueScreen({super.key});

  @override
  State<OrganiserStatistqueScreen> createState() =>
      _OrganiserStatistqueScreenState();
}

class _OrganiserStatistqueScreenState extends State<OrganiserStatistqueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("reservations"),
    );
  }
}
