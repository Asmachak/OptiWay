import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

@RoutePage()
class AdminStatScreen extends StatefulWidget {
  const AdminStatScreen({super.key});

  @override
  State<AdminStatScreen> createState() => _AdminStatScreenState();
}

class _AdminStatScreenState extends State<AdminStatScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text("home");
  }
}
