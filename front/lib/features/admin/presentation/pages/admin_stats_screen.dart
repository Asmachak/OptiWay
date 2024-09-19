import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reclamation/data/models/reclamation_model.dart';
import 'package:front/features/reclamation/presentation/blocs/reclamation_provider.dart';
import 'package:front/features/reservation/data/models/reservation_parking/reservationParking_model.dart';
import 'package:front/features/reservation/presentation/blocs/reservationParking_provider.dart';
import 'package:pie_chart/pie_chart.dart';

@RoutePage()
class AdminStatScreen extends ConsumerStatefulWidget {
  const AdminStatScreen({super.key});

  @override
  _AdminStatScreenState createState() => _AdminStatScreenState();
}

class _AdminStatScreenState extends ConsumerState<AdminStatScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch reservation parking data
      ref
          .read(reservationParkingNotifierProvider.notifier)
          .getAllReservationParking();
      // Fetch reclamation data
      ref.read(reclamationNotifierProvider.notifier).getReclamations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final getReclamationState = ref.watch(reclamationNotifierProvider);
    final getReservationState = ref.watch(reservationParkingNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getReclamationState.when(
              initial: () =>
                  const Center(child: Text('Loading reclamation data...')),
              loading: () => const Center(child: CircularProgressIndicator()),
              failure: (error) => Center(child: Text('Error: $error')),
              loaded: (reclamations) {
                // Calculate the percentages of reclamation causes
                final causeCountMap = _calculateCausePercentages(reclamations);

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Reclamation Cause Distribution',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      PieChart(
                        dataMap: causeCountMap, // Causes and their percentages
                        chartType:
                            ChartType.disc, // Full pie chart (instead of ring)
                        chartRadius: MediaQuery.of(context).size.width / 2.5,
                        animationDuration: const Duration(milliseconds: 800),
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true,
                          showChartValuesOutside: true,
                          decimalPlaces: 1,
                        ),
                        legendOptions: const LegendOptions(
                          showLegendsInRow: true,
                          legendPosition: LegendPosition.bottom,
                          showLegends: true,
                        ),
                      ),
                    ],
                  ),
                );
              },
              success: (rec) => const Center(child: Text('Select a model')),
            ),
            getReservationState.when(
              initial: () =>
                  const Center(child: Text('Loading reservation data...')),
              loading: () => const Center(child: CircularProgressIndicator()),
              failure: (error) => Center(child: Text('Error: $error')),
              loaded: (reservations) {
                // Calculate the percentages of reserved parkings
                final parkingCountMap =
                    _calculateParkingPercentages(reservations);

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Parking Reservation Distribution',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      PieChart(
                        dataMap:
                            parkingCountMap, // Parking reservations and percentages
                        chartType:
                            ChartType.disc, // Full pie chart (instead of ring)
                        chartRadius: MediaQuery.of(context).size.width / 2.5,
                        animationDuration: const Duration(milliseconds: 800),
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true,
                          showChartValuesOutside: true,
                          decimalPlaces: 1,
                        ),
                        legendOptions: const LegendOptions(
                          showLegendsInRow: true,
                          legendPosition: LegendPosition.bottom,
                          showLegends: true,
                        ),
                      ),
                    ],
                  ),
                );
              },
              success: (rec) => const Center(child: Text('Select a model')),
              extended: (reservation) =>
                  const Center(child: Text('Select a model')),
            ),
          ],
        ),
      ),
    );
  }

  // Calculate percentages for each cause of reclamation
  Map<String, double> _calculateCausePercentages(
      List<ReclamationModel> reclamations) {
    Map<String, int> causeCount = {};

    // Count occurrences of each cause
    for (var reclamation in reclamations) {
      if (causeCount.containsKey(reclamation.title!)) {
        causeCount[reclamation.title!] = causeCount[reclamation.title!]! + 1;
      } else {
        causeCount[reclamation.title!] = 1;
      }
    }

    // Calculate percentage
    int totalReclamations = reclamations.length;
    Map<String, double> causePercentages = causeCount.map((cause, count) {
      double percentage = (count / totalReclamations) * 100;
      return MapEntry(cause, percentage);
    });

    return causePercentages;
  }

  // Calculate percentages for each parking reserved
  Map<String, double> _calculateParkingPercentages(
      List<ReservationParkingModel> reservations) {
    Map<String, int> parkingCount = {};

    // Count occurrences of each reserved parking
    for (var reservation in reservations) {
      String parkingName = reservation.parkingName ?? 'Unknown Parking';
      if (parkingCount.containsKey(parkingName)) {
        parkingCount[parkingName] = parkingCount[parkingName]! + 1;
      } else {
        parkingCount[parkingName] = 1;
      }
    }

    // Calculate percentage
    int totalReservations = reservations.length;
    Map<String, double> parkingPercentages = parkingCount.map((parking, count) {
      double percentage = (count / totalReservations) * 100;
      return MapEntry(parking, percentage);
    });

    return parkingPercentages;
  }
}
