import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/data/models/reservation_model.dart';

class ExtendReservationContent extends ConsumerStatefulWidget {
  ReservationModel reservation;

  ExtendReservationContent({Key? key, required this.reservation})
      : super(key: key);

  @override
  ConsumerState<ExtendReservationContent> createState() =>
      _ExtendReservationContentState();
}

class _ExtendReservationContentState
    extends ConsumerState<ExtendReservationContent> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height *
            0.4, // Adjust the height as needed
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Center(
                child: Text(
                  "Pick the duration to add",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 51, 59, 103),
                  ),
                ),
              ),
            ),
            const Text(
              "End time",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 110, 110, 110),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ConstrainedBox(
              constraints:
                  const BoxConstraints.tightFor(height: 52, width: 350),
              child: TextButton(
                onPressed: () {
                  _selectDateTime(context);
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 130, 130, 130),
                    ),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 25),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Color.fromARGB(255, 107, 106, 106),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        selectedDate != null && selectedTime != null
                            ? '${selectedDate!.toLocal().toString().split(' ')[0]} ${selectedTime!.format(context)}'
                            : 'Select Date & Time',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ConstrainedBox(
              constraints:
                  const BoxConstraints.tightFor(height: 52, width: 350),
              child: ElevatedButton(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Extend Parking Time',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2026),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDate = pickedDate;
          selectedTime = pickedTime;
        });
      }
    }
  }
}
