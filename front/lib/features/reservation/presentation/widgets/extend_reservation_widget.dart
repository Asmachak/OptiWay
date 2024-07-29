import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/data/models/reservation/reservation_model.dart';
import 'package:front/features/reservation/presentation/blocs/reservation_providers.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservation/reservation_state.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class ExtendReservationContent extends ConsumerStatefulWidget {
  final ReservationModel reservation;

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
    final reservationState = ref.watch(reservationNotifierProvider);

    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
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
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
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
                onPressed: () async {
                  if (selectedDate != null && selectedTime != null) {
                    final DateTime newEndTime = DateTime(
                      selectedDate!.year,
                      selectedDate!.month,
                      selectedDate!.day,
                      selectedTime!.hour,
                      selectedTime!.minute,
                    );
                    final String formattedEndTime =
                        DateFormat('yyyy-MM-ddTHH:mm:ss').format(newEndTime);

                    var body = {
                      "EndedAt": formattedEndTime,
                    };

                    await Future(() {
                      ref
                          .read(reservationNotifierProvider.notifier)
                          .extendReservation(widget.reservation.id!, body);
                    }).then((_) {
                      if (reservationState is Extended) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Container(
                              padding: const EdgeInsets.all(16),
                              height: 90,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    "Congrats!",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  Text(
                                    " Your reservation is extended successfully!",
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
                        Navigator.pop(context);
                        Navigator.pop(context);

                        // Reload reservation information after extension
                        ref
                            .read(reservationNotifierProvider.notifier)
                            .getReservation(GetIt.instance
                                .get<AuthLocalDataSource>()
                                .currentUser!
                                .id!);
                      } else if (reservationState is Failure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Container(
                              padding: const EdgeInsets.all(16),
                              height: 90,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 175, 76, 76),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    "Oops!",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "SomeThing Went Wrong!",
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
                      }
                    });
                  } else {
                    print('Please select both date and time.');
                  }
                },
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
