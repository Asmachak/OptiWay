import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/event/presentation/blocs/event_list_provider.dart';
import 'package:front/features/event/presentation/blocs/event_provider.dart';
import 'package:front/features/event/presentation/blocs/state/event_organiser/event_state.dart';
import 'package:front/features/promo/presentation/widgets/promo_form.dart';
import 'package:front/features/organiser/data/data_sources/organiser_local_data_src.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:front/features/event/data/models/event_organiser/event_organiser.dart';

class EventCard extends ConsumerStatefulWidget {
  final EventOrganiserModel event;

  EventCard({required this.event});

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends ConsumerState<EventCard> {
  bool isExpanded = false;

  // Computed property to check if the event is expired
  bool get isExpired => DateTime.now().isAfter(widget.event.endedAt);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: ExpansionTile(
        onExpansionChanged: (expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.event.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (!isExpanded)
              Icon(Icons.circle,
                  color: !isExpired ? Colors.green : Colors.red, size: 14),
            const SizedBox(width: 8),
            Text(
              isExpired ? 'Expired' : 'Active',
              style: TextStyle(
                color: isExpired ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        children: [
          _buildReservationDetails(),
        ],
      ),
    );
  }

  Widget _buildReservationDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.circle,
                color: !isExpired ? Colors.green : Colors.red, size: 14),
            const SizedBox(width: 8),
            Text(
              !isExpired ? 'Status: Ongoing' : 'Status: Expired',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.calendar_today),
            const SizedBox(width: 8),
            Text(
              'Start Date: ${DateFormat('yyyy-MM-dd HH:mm').format(widget.event.createdAt)}',
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.calendar_today_outlined),
            const SizedBox(width: 8),
            Text(
              'End Date: ${DateFormat('yyyy-MM-dd HH:mm').format(widget.event.endedAt)}',
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.access_time),
            const SizedBox(width: 8),
            Text(
              'Duration: ${widget.event.endedAt.difference(widget.event.createdAt).inDays} Days',
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.place),
            const SizedBox(width: 8),
            Text(
              widget.event.place,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Add Promo Button
            if (!isExpired)
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        PromoFormModal(idevent: widget.event.id),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.local_offer, color: Colors.white), // Promo icon
                    SizedBox(width: 8),
                    Text(
                      'Add Promo',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            // Delete Button
            ElevatedButton(
              onPressed: () async {
                await ref
                    .read(eventNotifierProvider.notifier)
                    .deleteEvent(widget.event.id);

                var eventState = ref.watch(eventNotifierProvider);

                if (eventState is Deleted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Container(
                        padding: const EdgeInsets.all(16),
                        height: 90,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 175, 76, 76),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              "The Event is deleted Successfully!",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  );
                  // Reload the event list
                  ref.read(eventListNotifierProvider.notifier).getEvent(GetIt
                      .instance
                      .get<OrganiserLocalDataSource>()
                      .currentOrganiser!
                      .id!);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.delete, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Delete Reservation',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Placeholder method to handle adding a promo to the event
  void _addPromo(String eventId) {
    // Implement your logic here for adding a promo
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Promo added successfully!'),
      ),
    );
  }
}
