import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/parking/presentation/pages/parking_list_screen.dart';

@RoutePage()
class parkingsScreen extends ConsumerWidget {
  const parkingsScreen({Key? key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parkings Screen'),
      ),
      body: Container(
        child: ParkingListScreen(),
      ),
    );
  }
}
