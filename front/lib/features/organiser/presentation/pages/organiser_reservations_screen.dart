import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/features/reservation/presentation/pages/reservationOrganiser_screen.dart';

@RoutePage()
class OrganiserReservationScreen extends StatefulWidget {
  const OrganiserReservationScreen({super.key});

  @override
  State<OrganiserReservationScreen> createState() =>
      _OrganiserReservationScreenState();
}

class _OrganiserReservationScreenState
    extends State<OrganiserReservationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: ReservationOrganiserScreen()));
  }
}
