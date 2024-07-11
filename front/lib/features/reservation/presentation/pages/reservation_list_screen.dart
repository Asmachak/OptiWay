import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/presentation/widgets/booking_switcher.dart';
import 'package:front/routes/app_routes.gr.dart';

@RoutePage()
class ReservationListScreen extends ConsumerStatefulWidget {
  const ReservationListScreen({super.key});

  @override
  ConsumerState<ReservationListScreen> createState() =>
      _ReservationListScreenState();
}

class _ReservationListScreenState extends ConsumerState<ReservationListScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.router.replace(UserManagementRoute()),
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
