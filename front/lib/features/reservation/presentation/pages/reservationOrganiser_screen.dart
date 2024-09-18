import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/organiser/data/data_sources/organiser_local_data_src.dart';
import 'package:front/features/reclamation/presentation/blocs/reclamation_provider.dart';
import 'package:front/features/reclamation/presentation/blocs/state/reclamation_state.dart';
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

    // Fetch reservations when screen is loaded
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

  // Trigger function when reclamation is selected
  void _onReclamationSelected(String title, String userId) {
    final body = {"title": title, "targetType": "user"};

    ref.read(reclamationNotifierProvider.notifier).addReclamation(
        GetIt.instance.get<OrganiserLocalDataSource>().currentOrganiser!.id!,
        userId,
        body);

    // No need to listen to state here since it's handled in the build method
  }

  // Show the modal to report or act on a reservation
  void _showReportModal(BuildContext context, String userName, String userId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 270,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Report User $userName',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              _buildModalOption(
                icon: Icons.flag,
                text: 'Report Fraudulent Activity',
                onTap: () => _onReclamationSelected(
                    "Report Fraudulent Activity", userId),
              ),
              _buildModalOption(
                icon: Icons.error_outline,
                text: 'Report Incorrect Information',
                onTap: () => _onReclamationSelected(
                    "Report Incorrect Information", userId),
              ),
              _buildModalOption(
                icon: Icons.cancel,
                text: 'Cancel Reservation',
                onTap: () =>
                    _onReclamationSelected("Cancel Reservation", userId),
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper method to build modal options
  Widget _buildModalOption(
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the reclamation state and handle success or failure
    ref.listen<ReclamationState>(reclamationNotifierProvider, (previous, next) {
      if (next is Success) {
        // Close the modal only after success
        Navigator.pop(context);

        // Show the success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              padding: const EdgeInsets.all(16),
              height: 90,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 73, 82, 73),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: const Column(
                children: [
                  Text("Your reclamation has been successfully reported!",
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
      } else if (next is Failure) {
        // Show the failure message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to report reclamation: ${next.exception}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

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
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          event?["title"] ?? "Untitled Event",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  children: [
                    SizedBox(
                      height: 150,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: reservation.reservations!.length > 3
                            ? 3
                            : reservation.reservations!.length,
                        separatorBuilder: (context, index) => const Divider(),
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
                            trailing: IconButton(
                              icon: const Icon(Icons.flag),
                              onPressed: () {
                                _showReportModal(
                                    context,
                                    res["user"]["name"].toString(),
                                    res["user"]["id"].toString());
                              },
                            ),
                          );
                        },
                      ),
                    ),
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
                                        const Divider(),
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
                                        trailing: IconButton(
                                          icon: const Icon(Icons.flag),
                                          onPressed: () {
                                            _showReportModal(
                                                context,
                                                res["reservation"]["id"],
                                                res["user"]["id"]);
                                          },
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
