import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/parking/presentation/pages/parking_list_screen.dart';
import 'package:front/routes/app_routes.gr.dart';

@RoutePage()
class parkingsScreen extends ConsumerWidget {
  const parkingsScreen({Key? key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () => AutoRouter.of(context).push(const MainRoute()),
        //   icon: const Icon(Icons.arrow_back_ios_new_rounded),
        // ),
        leading: null,
        automaticallyImplyLeading: false,
        title: const Align(
            alignment: Alignment.center, child: Text('Parkings Screen')),
      ),
      body: const ParkingListScreen(),
    );
  }
}
