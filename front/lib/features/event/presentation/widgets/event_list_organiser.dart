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
    // Fetching the event list in initState using ref.read
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(eventListNotifierProvider.notifier).getEvent(GetIt.instance
          .get<OrganiserLocalDataSource>()
          .currentOrganiser!
          .id!); // Adjust this method name based on your provider logic
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watching the eventListNotifierProvider to react to state changes
    final eventlistState = ref.watch(eventListNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Event List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: eventlistState.when(
          initial: () {},
          loaded: (events) => ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return EventCard(
                event: event,
              );
            },
          ),
          loading: () => Center(child: CircularProgressIndicator()),
          failure: (error) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
