import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/features/paiement/presentation/pages/paiement_screen.dart';

@RoutePage()
class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [PaymentPage()],
      ),
    );
  }
}
