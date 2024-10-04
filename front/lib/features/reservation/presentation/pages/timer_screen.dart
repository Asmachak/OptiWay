import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/data/models/reservation/reservation_model.dart';
import 'package:front/features/reservation/presentation/blocs/cancelReservation_provider.dart';
import 'package:front/features/reservation/presentation/blocs/state/cancelReservation/cancel_reservation_state.dart';
import 'package:front/features/reservation/presentation/blocs/timerProvider.dart';
import 'package:front/features/reservation/presentation/widgets/extend_reservation_widget.dart';
import 'package:front/routes/app_routes.gr.dart';

@RoutePage()
class TimerScreen extends ConsumerStatefulWidget {
  ReservationModel reservation;

  TimerScreen({Key? key, required this.reservation}) : super(key: key);

  @override
  ConsumerState<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends ConsumerState<TimerScreen> {
  late int duration;

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  void _initializeTimer() {
    DateTime dateTimeEnd =
        DateTime.parse(widget.reservation.EndedAt!).toLocal();
    DateTime now = DateTime.now();
    Duration difference = dateTimeEnd.difference(now);

    setState(() {
      if (difference.isNegative) {
        duration = 0;
      } else {
        duration = difference.inSeconds;
      }
    });

    // Reinitialize the provider to update the countdown timer
    ref.read(countdownTimerProvider(duration).notifier).initialize();
  }

  @override
  Widget build(BuildContext context) {
    final remainingTime = ref.watch(countdownTimerProvider(duration));

    // Using `ref.listen` within the `build` method to handle state changes
    ref.listen<CancelReservationState>(
      CancelReservationNotifierProvider,
      (previous, next) {
        if (next is Canceled) {
          _showCancellationSuccessDialog(context);
        } else if (next is Failure) {
          _showFailureDialog(context, "An error occurred while canceling.");
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Timer"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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
                                      widget.reservation
                                              .ReservationParking!["parking"]
                                          ?["parkingName"]!,
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
                                      '${widget.reservation.ReservationParking!["vehicule"]?["model"]} ${widget.reservation.ReservationParking!["vehicule"]?["matricule"]} ',
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
                                              widget.reservation.EndedAt!)
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
                                      "${widget.reservation.User?["phone"] ?? ''}",
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
              // Extend Parking Time Button
              ConstrainedBox(
                constraints:
                    const BoxConstraints.tightFor(height: 52, width: 353),
                child: ElevatedButton(
                  onPressed: () async {
                    final updatedReservation =
                        await showModalBottomSheet<ReservationModel>(
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

                    if (updatedReservation != null) {
                      setState(() {
                        widget.reservation =
                            updatedReservation; // Update reservation
                        _initializeTimer(); // Recalculate timer
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Extend Parking Time',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Cancel Reservation Button with Confirmation Dialog
              ConstrainedBox(
                constraints:
                    const BoxConstraints.tightFor(height: 52, width: 353),
                child: ElevatedButton(
                  onPressed: () async {
                    bool shouldCancel =
                        await _showCancelConfirmationDialog(context);
                    if (shouldCancel) {
                      // Trigger cancellation process
                      ref
                          .read(CancelReservationNotifierProvider.notifier)
                          .cancelReservation(widget.reservation.id!);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 138, 146, 194),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Cancel Reservation',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  // Function to show confirmation dialog
  Future<bool> _showCancelConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Cancel Reservation'),
              content: const Text(
                  'Are you sure you want to cancel the reservation?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        ) ??
        false; // Return false if dialog is dismissed
  }

  // Function to show success message after cancellation
  void _showCancellationSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reservation Cancelled'),
          content: const Text(
              'Your reservation has been cancelled. Please report the transaction in your transaction history to earn a reward!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                AutoRouter.of(context).replace(ReservationListRoute());
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function to show failure message if cancellation fails
  void _showFailureDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancellation Failed'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
