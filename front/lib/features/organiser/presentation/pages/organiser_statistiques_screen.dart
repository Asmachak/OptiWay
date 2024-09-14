import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/organiser/data/data_sources/organiser_local_data_src.dart';
import 'package:front/features/rate/presentation/blocs/avg_rate_provider.dart';
import 'package:front/features/reservation/presentation/blocs/reservationOrganiser_provider.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class OrganiserStatistqueScreen extends StatefulWidget {
  const OrganiserStatistqueScreen({super.key});

  @override
  State<OrganiserStatistqueScreen> createState() =>
      _OrganiserStatistqueScreenState();
}

class _OrganiserStatistqueScreenState extends State<OrganiserStatistqueScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StatsReservationOrganiserScreen(),
    );
  }
}

class StatsReservationOrganiserScreen extends ConsumerStatefulWidget {
  const StatsReservationOrganiserScreen({super.key});

  @override
  _StatsReservationOrganiserScreenState createState() =>
      _StatsReservationOrganiserScreenState();
}

class _StatsReservationOrganiserScreenState
    extends ConsumerState<StatsReservationOrganiserScreen> {
  // Create a list to hold events and their average rates
  List<Map<String, dynamic>> eventsWithAvgRates = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final organiserId =
          GetIt.instance.get<OrganiserLocalDataSource>().currentOrganiser!.id!;

      // Fetch reservations
      await ref
          .read(reservationOrganiserNotifierProvider.notifier)
          .getReservationOrganiser(organiserId);

      final reservationState = ref.read(reservationOrganiserNotifierProvider);
      reservationState.maybeWhen(
        loaded: (reservations) async {
          // Iterate through reservations and calculate the average rate
          for (var reservation in reservations) {
            final eventId = reservation.event?["id"];
            if (eventId != null) {
              // Fetch the average rate for the event
              final avgRate = await _fetchAverageRate(eventId);

              // Store event and average rate in the list
              eventsWithAvgRates.add({
                'event': reservation.event!['title'],
                'rate': avgRate,
              });

              setState(() {}); // Trigger UI update after each event fetch
            }
          }
        },
        orElse: () {},
      );
    });
  }

  Future<double> _fetchAverageRate(String eventId) async {
    await ref.read(avgRateNotifierProvider.notifier).avgRate(eventId);

    final avgState = ref.read(avgRateNotifierProvider);

    double avgRate = 0.0;
    avgState.maybeWhen(
      success: (avg) {
        avgRate = avg.averageRate!;
      },
      orElse: () {},
    );

    return avgRate;
  }

  @override
  Widget build(BuildContext context) {
    final reservationOrganiserState =
        ref.watch(reservationOrganiserNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation Organiser'),
      ),
      body: reservationOrganiserState.when(
        initial: () => const Center(
          child: Text('No reservations loaded yet.'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        loaded: (reservations) {
          final eventsWithReservations = reservations
              .where((reservation) => reservation.reservations!.isNotEmpty)
              .toList();

          if (eventsWithReservations.isEmpty) {
            return const Center(
              child: Text('No events with reservations.'),
            );
          }

          final List<BarChartGroupData> barGroupsFillRate = [];
          final List<BarChartGroupData> barGroupsAvgRate = [];

          for (var i = 0; i < eventsWithReservations.length; i++) {
            final reservation = eventsWithReservations[i];
            final event = reservation.event;

            final totalReservedTickets = reservation.reservations!.fold(
              0,
              (sum, res) {
                final nbreticket =
                    int.tryParse(res["reservation"]["Nbreticket"].toString()) ??
                        0;
                return sum + nbreticket;
              },
            );

            final capacity = event?["capacity"] ?? 1;
            final fillRate = (totalReservedTickets / capacity) * 100;

            barGroupsFillRate.add(
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: fillRate,
                    color: Colors.blue,
                    width: 20,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
            );
          }

          // Filter out events with zero average ratings for the second chart
          final filteredEventsWithAvgRates =
              eventsWithAvgRates.where((event) => event['rate'] > 0).toList();

          for (var i = 0; i < filteredEventsWithAvgRates.length; i++) {
            final event = filteredEventsWithAvgRates[i];
            final title = event['event'] ?? "Untitled";
            final rate = event['rate'];

            barGroupsAvgRate.add(
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: rate,
                    color: Colors.green,
                    width: 20,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Event occupancy rate',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: 250,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 100,
                        barGroups: barGroupsFillRate,
                        titlesData: FlTitlesData(
                          leftTitles: const AxisTitles(
                            sideTitles:
                                SideTitles(showTitles: true, reservedSize: 40),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                if (index < eventsWithReservations.length) {
                                  final eventData =
                                      eventsWithReservations[index];
                                  return Text(
                                    eventData.event?['title'] ?? "Untitled",
                                    style: const TextStyle(fontSize: 10),
                                    overflow: TextOverflow.ellipsis,
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        gridData: const FlGridData(show: false),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Average Ratings of Events',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: 250,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 5,
                        barGroups: barGroupsAvgRate,
                        titlesData: FlTitlesData(
                          leftTitles: const AxisTitles(
                            sideTitles:
                                SideTitles(showTitles: true, reservedSize: 40),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                if (index < filteredEventsWithAvgRates.length) {
                                  final eventData =
                                      filteredEventsWithAvgRates[index];
                                  return Text(
                                    eventData['event'] ?? "Untitled",
                                    style: const TextStyle(fontSize: 10),
                                    overflow: TextOverflow.ellipsis,
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        gridData: const FlGridData(show: false),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
        failure: (error) => Center(
          child: Text('Failed to load reservations: $error'),
        ),
      ),
    );
  }
}
