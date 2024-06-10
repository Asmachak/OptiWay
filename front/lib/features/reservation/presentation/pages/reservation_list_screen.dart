import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/presentation/widgets/booking_switcher.dart';

@RoutePage()
class ReservationListScreen extends ConsumerStatefulWidget {
  // Changed to ConsumerStatefulWidget
  const ReservationListScreen({super.key});

  @override
  ConsumerState<ReservationListScreen> createState() =>
      _ReservationListScreenState(); // Updated return type
}

class _ReservationListScreenState extends ConsumerState<ReservationListScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
  }

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
          child: Text(
            'My Bookings',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
          ),
        ),
      ),
      body: BookingSwitcher(),
    );
  }
}
