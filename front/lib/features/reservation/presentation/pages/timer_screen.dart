import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/data/models/reservation_model.dart';
import 'package:front/features/reservation/presentation/blocs/timerProvider.dart';
import 'package:front/features/reservation/presentation/widgets/extend_reservation_widget.dart';

@RoutePage()
class TimerScreen extends ConsumerStatefulWidget {
  final ReservationModel reservation;

  TimerScreen({Key? key, required this.reservation}) : super(key: key);

  @override
  ConsumerState<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends ConsumerState<TimerScreen> {
  late final int duration;
  late final String formatedDuration;
  String formatDuration(Duration duration) {
    int days = duration.inDays;
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);

    return '${days}d${hours}h${minutes}min';
  }

  @override
  void initState() {
    super.initState();
    DateTime dateTimeEnd =
        DateTime.parse(widget.reservation.endedAt!).toLocal();
    DateTime now = DateTime.now();
    Duration difference = dateTimeEnd.difference(now);
    formatedDuration = formatDuration(difference);

    if (difference.isNegative) {
      duration = 0;
    } else {
      duration = difference.inSeconds;
    }

    ref.read(countdownTimerProvider(duration).notifier).initialize();
  }

  @override
  Widget build(BuildContext context) {
    final remainingTime = ref.watch(countdownTimerProvider(duration));

    String formatTime(int seconds) {
      int hours = seconds ~/ 3600;
      int minutes = (seconds % 3600) ~/ 60;
      int secs = seconds % 60;
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Timer"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  height: 220,
                  width: 220,
                  decoration: const BoxDecoration(
                    color: Colors.indigo,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Time Left",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              formatTime(remainingTime),
                              style: const TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Parking Name",
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                      ),
                                    ),
                                    Text(
                                      widget
                                          .reservation.parking?["parkingName"]!,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Parking spot",
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                      ),
                                    ),
                                    Text(
                                      "spot", // Replace with actual data
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Parking area",
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                      ),
                                    ),
                                    Text(
                                      "area", // Replace with actual data
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Vehicle",
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                      ),
                                    ),
                                    Text(
                                      '${widget.reservation.vehicle?["model"]} ${widget.reservation.vehicle?["matricule"]} ',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date",
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                      ),
                                    ),
                                    Text(
                                      DateTime.parse(
                                              widget.reservation.endedAt!)
                                          .toLocal()
                                          .toString()
                                          .split(" ")[0],
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Phone",
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                      ),
                                    ),
                                    Text(
                                      "${widget.reservation.user?["phone"] ?? ''}",
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints:
                    const BoxConstraints.tightFor(height: 52, width: 353),
                child: ElevatedButton(
                  onPressed: () async {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30.0)),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      builder: (context) => ExtendReservationContent(
                        reservation: widget.reservation,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('Extend Parking Time ',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
