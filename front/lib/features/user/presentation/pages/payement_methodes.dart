import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/features/user/presentation/widgets/paiement_card_widget.dart';

@RoutePage()
class PaiementMethodeScreen extends StatefulWidget {
  const PaiementMethodeScreen({super.key});

  @override
  State<PaiementMethodeScreen> createState() => _PaiementMethodeScreenState();
}

class _PaiementMethodeScreenState extends State<PaiementMethodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paiement Methodes"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            PaiementCardWidget(
                title: "Credit Card",
                imagePath: "assets/creadit_card.png",
                onPress: () {}),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            PaiementCardWidget(
                title: "PayPal",
                imagePath: "assets/PayPalCard.png",
                onPress: () {}),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            PaiementCardWidget(
                title: "Google Pay",
                imagePath: "assets/google_pay.webp",
                onPress: () {}),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            PaiementCardWidget(
                title: "Pay on spot",
                imagePath: "assets/wallet.png",
                onPress: () {}),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
