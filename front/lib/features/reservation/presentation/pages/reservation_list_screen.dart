import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/features/reservation/presentation/widgets/booking_switcher.dart';

@RoutePage()
class reservationListScreen extends StatefulWidget {
  const reservationListScreen({super.key});

  @override
  State<reservationListScreen> createState() => _reservationListScreenState();
}

class _reservationListScreenState extends State<reservationListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('My Bookings'),
        ),
      ),
      body: BookingSwitcher(),
    );
  }
}
