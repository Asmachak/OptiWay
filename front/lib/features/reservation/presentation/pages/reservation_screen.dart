import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/parking/data/models/parking_model.dart';
import 'package:front/features/reservation/presentation/blocs/jsonDataProvider.dart';
import 'package:front/features/reservation/presentation/widgets/seperator.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:table_calendar/table_calendar.dart';

DateTime? startDateTime;
DateTime? endDateTime;

final selectedDateProvider = StateProvider<DateTime?>((ref) {
  return DateTime.now();
});
final selectedStartTimeProvider = StateProvider<TimeOfDay?>((ref) => null);
final selectedEndTimeProvider = StateProvider<TimeOfDay?>((ref) => null);
final durationProvider = Provider<Duration?>((ref) {
  final startTime = ref.watch(selectedStartTimeProvider);
  final endTime = ref.watch(selectedEndTimeProvider);

  if (startTime != null && endTime != null) {
    startDateTime = convertToDateTime(startTime);
    endDateTime = convertToDateTime(endTime);

    return endDateTime?.difference(startDateTime!);
  }

  return null;
});

DateTime convertToDateTime(TimeOfDay time) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, time.hour, time.minute);
}

@RoutePage()
class ReservationScreen extends ConsumerStatefulWidget {
  final String idparking;
  final ParkingModel parking;

  ReservationScreen({Key? key, required this.idparking, required this.parking})
      : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends ConsumerState<ReservationScreen> {
  var price = 5.0;

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedStartTime = ref.watch(selectedStartTimeProvider);
    final selectedEndTime = ref.watch(selectedEndTimeProvider);
    final duration = ref.watch(durationProvider);

    void _onDaySelected(DateTime day, DateTime? focusedDay) {
      ref.read(selectedDateProvider.notifier).state = day;
    }

    Future<void> _selectStartTime(BuildContext context, WidgetRef ref) async {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        ref.read(selectedStartTimeProvider.notifier).state = pickedTime;
      }
    }

    Future<void> _selectEndTime(BuildContext context, WidgetRef ref) async {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        ref.read(selectedEndTimeProvider.notifier).state = pickedTime;

        final startDateTime = selectedStartTime != null
            ? convertToDateTime(selectedStartTime)
            : null;

        if (startDateTime != null) {
          final endDateTime = convertToDateTime(pickedTime);
          if (endDateTime.isBefore(startDateTime)) {
            // Show error message dialog
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 234, 111, 103),
                  title: const Text(
                    'Oups !',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: const Text(
                    'End time cannot be earlier than start time.',
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        ref.read(selectedEndTimeProvider.notifier).state = null;
                      },
                      style: TextButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                      ),
                      child: const Text(
                        'Pick another time',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        }
      }
    }

    final firstDay = DateTime.now();
    final lastDay = firstDay.add(const Duration(days: 30));
    final validFocusedDay =
        selectedDate != null && selectedDate.isAfter(firstDay)
            ? selectedDate
            : firstDay;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Booking Screen'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Select a date',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 46, 57, 121)),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: TableCalendar(
                  locale: "en_US",
                  rowHeight: 38,
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronMargin: EdgeInsets.all(0),
                    rightChevronMargin: EdgeInsets.all(0),
                    headerPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                  ),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => isSameDay(day, selectedDate),
                  firstDay: firstDay,
                  focusedDay: validFocusedDay,
                  lastDay: lastDay,
                  onDaySelected: _onDaySelected,
                ),
              ),
            ),
            const MySeparator(),
            const SizedBox(
              height: 10,
            ),
            Text(
              duration == null
                  ? 'Duration'
                  : 'Duration ${duration.inHours.remainder(24)}h ${duration.inMinutes.remainder(60)}min',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 46, 57, 121)),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text("Start time"),
                      TextButton(
                        onPressed: () => _selectStartTime(context, ref),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                                color: Color.fromARGB(255, 130, 130, 130)),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.access_time,
                                  color: Color.fromARGB(255, 107, 106, 106)),
                              const SizedBox(width: 8),
                              Text(
                                selectedStartTime != null
                                    ? selectedStartTime.format(context)
                                    : "Start time",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 82, 82, 82),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        "End time",
                        textAlign: TextAlign.start,
                      ),
                      TextButton(
                        onPressed: () => _selectEndTime(context, ref),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                                color: Color.fromARGB(255, 130, 130, 130)),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.access_time,
                                  color: Color.fromARGB(255, 107, 106, 106)),
                              const SizedBox(width: 8),
                              Text(
                                selectedEndTime != null
                                    ? selectedEndTime.format(context)
                                    : "End time",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 82, 82, 82),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const MySeparator(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Price',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 46, 57, 121)),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    children: [
                      Text(
                        '$price Euro/',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '1hour',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 46, 57, 121)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (duration != null)
              Row(
                children: [
                  const Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Total Price',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 46, 57, 121)),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Row(
                      children: [
                        Text(
                          '${((duration.inMinutes * (price / 60))).toInt()}Euro/',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${duration.inHours.remainder(24)} hour',
                          style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 46, 57, 121)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        final jsonData =
                            ref.read(reservationParkingDataProvider);

                        jsonData['idparking'] = widget.idparking;
                        jsonData['parking'] = widget.parking.parkingName;
                        jsonData['CreatedAt'] =
                            startDateTime?.toIso8601String();
                        jsonData['EndedAt'] = endDateTime?.toIso8601String();
                        jsonData['tarif'] =
                            ((duration!.inMinutes * (price / 60))).toInt();

                        if (startDateTime != null && endDateTime != null) {
                          AutoRouter.of(context)
                              .push(VehiculeListReservationRoute());
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor:
                                    const Color.fromARGB(255, 234, 111, 103),
                                title: const Text(
                                  'Oups !',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: const Text(
                                  'Your informations are missing',
                                  style: TextStyle(color: Colors.white),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      ref
                                          .read(
                                              selectedEndTimeProvider.notifier)
                                          .state = null;
                                    },
                                    style: TextButton.styleFrom(
                                      side:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    child: const Text(
                                      'Return',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo[50]),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide.none,
                          ),
                        ),
                      ),
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
