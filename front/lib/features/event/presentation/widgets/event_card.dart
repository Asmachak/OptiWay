import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:front/features/event/data/models/event_organiser/event_organiser.dart';

class EventCard extends StatefulWidget {
  final EventOrganiserModel event;

  EventCard({required this.event});

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
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
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              // Add delete functionality here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min, // To keep the button small
              children: [
                Icon(Icons.delete, color: Colors.white), // Basket icon
                SizedBox(width: 8),
                Text(
                  'Delete Reservation',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
