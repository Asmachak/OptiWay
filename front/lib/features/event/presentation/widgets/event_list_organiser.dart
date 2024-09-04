import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/event/presentation/blocs/event_list_provider.dart';
import 'package:front/features/event/presentation/widgets/event_card.dart';
import 'package:front/features/organiser/data/data_sources/organiser_local_data_src.dart';
import 'package:get_it/get_it.dart';

class EventListWidget extends ConsumerStatefulWidget {
  const EventListWidget({super.key});

  @override
  _EventListWidgetState createState() => _EventListWidgetState();
}

class _EventListWidgetState extends ConsumerState<EventListWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchEvents();
    });
  }

  void _fetchEvents() {
    final organiserId =
        GetIt.instance.get<OrganiserLocalDataSource>().currentOrganiser!.id!;
    ref.read(eventListNotifierProvider.notifier).getEvent(organiserId);
  }

  @override
  Widget build(BuildContext context) {
    final eventlistState = ref.watch(eventListNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: eventlistState.when(
          initial: () => const Center(child: Text('No events found')),
          loaded: (events) {
            // Create a modifiable copy of the events list
            final sortedEvents = List.from(events)
              ..sort((a, b) {
                final now = DateTime.now();
                final aExpired = now.isAfter(a.endedAt);
                final bExpired = now.isAfter(b.endedAt);
                return aExpired == bExpired ? 0 : (aExpired ? 1 : -1);
              });

            return ListView.builder(
              itemCount: sortedEvents.length,
              itemBuilder: (context, index) {
                final event = sortedEvents[index];
                return EventCard(event: event);
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          failure: (error) => Center(child: Text('Error: $error')),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchEvents, // Reload the event list on button press
        child: const Icon(Icons.refresh),
        tooltip: 'Reload Events',
      ),
    );
  }
}
