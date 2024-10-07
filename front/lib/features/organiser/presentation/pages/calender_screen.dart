import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:front/features/event/data/models/event_organiser/event_organiser.dart';
import 'package:front/features/event/presentation/blocs/event_list_provider.dart';
import 'package:front/features/organiser/data/data_sources/organiser_local_data_src.dart';
import 'package:get_it/get_it.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends ConsumerStatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final Map<EventOrganiserModel, Color> _eventColors =
      {}; // Assign colors to events

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
    final eventListState = ref.watch(eventListNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: eventListState.maybeWhen(
        loaded: (events) {
          return Column(
            children: [
              TableCalendar<EventOrganiserModel>(
                firstDay: DateTime(2020),
                lastDay: DateTime(2050),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                eventLoader: (day) => _getEventsForDay(day, events),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    final eventsForDay = _getEventsForDay(day, events);
                    if (eventsForDay.isNotEmpty) {
                      return _buildEventCell(day, eventsForDay);
                    }
                    return null;
                  },
                ),
                calendarFormat: CalendarFormat.month,
                startingDayOfWeek: StartingDayOfWeek.monday,
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: _buildEventList(events),
              ),
            ],
          );
        },
        orElse: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  // Display events for the selected day
  Widget _buildEventList(List<EventOrganiserModel> events) {
    final eventsForSelectedDay = _getEventsForDay(_selectedDay, events);

    if (eventsForSelectedDay.isEmpty) {
      return Center(child: Text('No events for this day'));
    }

    return ListView.builder(
      itemCount: eventsForSelectedDay.length,
      itemBuilder: (context, index) {
        final event = eventsForSelectedDay[index];
        return ListTile(
          title: Text(event.title),
          subtitle: Text(
              '${DateFormat.yMMMd().format(event.createdAt)} - ${DateFormat.yMMMd().format(event.endedAt)}'),
        );
      },
    );
  }

  // Get events for a specific day
  List<EventOrganiserModel> _getEventsForDay(
      DateTime day, List<EventOrganiserModel> allEvents) {
    return allEvents.where((event) {
      return day.isAfter(event.createdAt.subtract(const Duration(days: 1))) &&
          day.isBefore(event.endedAt.add(const Duration(days: 1)));
    }).toList();
  }

  // Create a unique color for each event (ensure same color is applied across days)
  Color _getEventColor(EventOrganiserModel event) {
    if (!_eventColors.containsKey(event)) {
      _eventColors[event] = _generateRandomColor();
    }
    return _eventColors[event]!;
  }

  // Generate random color for event
  Color _generateRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  // Build the event cell for the calendar (support overlapping events)
  Widget _buildEventCell(DateTime day, List<EventOrganiserModel> events) {
    // Check if there are overlapping events, and split the cell accordingly
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: Stack(
        children: [
          ...events.asMap().entries.map((entry) {
            int index = entry.key;
            EventOrganiserModel event = entry.value;
            return Positioned(
              top: index * 10.0, // Stack events vertically
              left: 0,
              right: 0,
              height: 15,
              child: Container(
                decoration: BoxDecoration(
                  color: _getEventColor(event).withOpacity(0.5),
                  borderRadius: _getEventBorderRadius(event, day),
                ),
              ),
            );
          }).toList(),
          Center(
            child: Text(
              day.day.toString(),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  // Determine the border radius (left rounded for start, right rounded for end, no rounding for middle days)
  BorderRadiusGeometry? _getEventBorderRadius(
      EventOrganiserModel event, DateTime day) {
    if (isSameDay(day, event.createdAt)) {
      return BorderRadius.horizontal(left: Radius.circular(10));
    } else if (isSameDay(day, event.endedAt)) {
      return BorderRadius.horizontal(right: Radius.circular(10));
    }
    return null;
  }
}
