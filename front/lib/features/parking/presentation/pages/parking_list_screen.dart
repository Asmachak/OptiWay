import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/parking/presentation/blocs/parking_provider.dart';
import 'package:front/features/parking/presentation/widgets/parking_widget.dart';

class ParkingListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(parkingNotifierProvider); // Read the state from the provider

    return Scaffold(
        body: SingleChildScrollView(
      child: state.when(
        initial: () {
          return Text("initial");
        },
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
        loaded: (parkings) {
          return SingleChildScrollView(
            child: Column(
              children: parkings.map((parking) {
                return ParkingWidget(
                  title: parking.parkingName ?? '',
                  adress: parking.adress ?? '',
                );
              }).toList(),
            ),
          );
        },
        failure: (exception) {
          return Text("$exception");
        },
        success: () {
          return Text("success");
        },
      ),
    ));
  }
}
