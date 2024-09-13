import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/organiser/data/data_sources/organiser_local_data_src.dart';
import 'package:front/features/reservation/presentation/blocs/reservationOrganiser_provider.dart';
import 'package:get_it/get_it.dart';

class ReservationOrganiserScreen extends ConsumerStatefulWidget {
  const ReservationOrganiserScreen({super.key});

  @override
  _ReservationOrganiserScreenState createState() =>
      _ReservationOrganiserScreenState();
}

class _ReservationOrganiserScreenState
    extends ConsumerState<ReservationOrganiserScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(reservationOrganiserNotifierProvider.notifier)
          .getReservationOrganiser(
            GetIt.instance
                .get<OrganiserLocalDataSource>()
                .currentOrganiser!
                .id!,
          );
    });
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
          // Filter events that have reservations
          final eventsWithReservations = reservations
              .where((reservation) => reservation.reservations!.isNotEmpty)
              .toList();

          if (eventsWithReservations.isEmpty) {
            return const Center(
              child: Text('No events with reservations.'),
            );
          }

          return ListView.builder(
            itemCount: eventsWithReservations.length,
            itemBuilder: (context, index) {
              final reservation = eventsWithReservations[index];
              final event = reservation.event;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ExpansionTile(
                  title: Row(
                    children: [
                      // Display event icon as a small, round thumbnail
                      if (event != null && event["image_url"] != null)
                        ClipOval(
                          child: Image.network(
                            event["image_url"]!,
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        const ClipOval(
                          child: Icon(Icons.image, size: 40),
                        ),

                      const SizedBox(
                          width:
                              10), // Add some spacing between image and title

                      // Event title
                      Expanded(
                        child: Text(
                          event?["title"] ?? "Untitled Event",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow
                              .ellipsis, // Ensure long titles are truncated
                        ),
                      ),
                    ],
                  ),
                  children: [
                    // Limit display to show only 3 reservations, scrollable if necessary
                    SizedBox(
                      height:
                          150, // Set height to allow scrolling within a fixed space
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: reservation.reservations!.length > 3
                            ? 3
                            : reservation.reservations!.length,
                        separatorBuilder: (context, index) =>
                            const Divider(), // Add a divider between each reservation
                        itemBuilder: (context, resIndex) {
                          final res = reservation.reservations![resIndex];
                          final nbreticket = res["reservation"]["Nbreticket"];

                          return ListTile(
                            title: Text(
                                'Reservation ID: ${res["reservation"]["id"]}'),
                            subtitle: Text(
                              'User: ${res["user"]["name"]} ${res["user"]["last_name"]}\n'
                              'Ticket number: ${nbreticket ?? "Not available"}',
                            ),
                          );
                        },
                      ),
                    ),
                    // Show button to view all reservations if there are more than 3
                    if (reservation.reservations!.length > 3)
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    'All Reservations for ${event?["title"]}'),
                                content: SizedBox(
                                  height: 400,
                                  width: double.maxFinite,
                                  child: ListView.separated(
                                    itemCount: reservation.reservations!.length,
                                    separatorBuilder: (context, index) =>
                                        const Divider(), // Divider in the full list
                                    itemBuilder: (context, resIndex) {
                                      final res =
                                          reservation.reservations![resIndex];
                                      final nbreticket =
                                          res["reservation"]["Nbreticket"];

                                      return ListTile(
                                        title: Text(
                                            'Reservation ID: ${res["reservation"]["id"]}'),
                                        subtitle: Text(
                                          'User: ${res["user"]["name"]} ${res["user"]["last_name"]}\n'
                                          'Ticket number: ${nbreticket ?? "Not available"}',
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('See All Reservations'),
                      ),
                  ],
                ),
              );
            },
          );
        },
        failure: (error) => Center(
          child: Text('Failed to load reservations: $error'),
        ),
      ),
    );
  }
}
