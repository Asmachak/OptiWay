import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/rate/presentation/blocs/check_rate_provider.dart';
import 'package:front/features/rate/presentation/blocs/state/check_rate/check_state.dart';
import 'package:front/features/rate/presentation/pages/rate_content.dart';
import 'package:front/features/reservation/data/models/reservation_model.dart';
import 'package:front/routes/app_routes.gr.dart';

class BookingCardWidget extends ConsumerStatefulWidget {
  const BookingCardWidget({Key? key, required this.reservation})
      : super(key: key);
  final ReservationModel reservation;

  @override
  _BookingCardWidgetState createState() => _BookingCardWidgetState();
}

class _BookingCardWidgetState extends ConsumerState<BookingCardWidget> {
  late CheckRateState checkRateState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(checkRateNotifierProvider.notifier)
          .checkRate(widget.reservation.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    checkRateState = ref.watch(checkRateNotifierProvider);

    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    "assets/parking.jpg",
                    width: 110,
                    height: 110,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.reservation.parking?["parkingName"] ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.reservation.parking?["adress"] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      if (widget.reservation.state == "ended") {
                        await ref
                            .read(checkRateNotifierProvider.notifier)
                            .checkRate(widget.reservation.id!);
                        setState(() {
                          checkRateState = ref.watch(checkRateNotifierProvider);
                        });
                        print("check rate $checkRateState");
                        double eventRate = 0.0;
                        double parkingRate = 0.0;

                        checkRateState.when(
                          initial: () {},
                          loading: () {},
                          failure: (exception) {},
                          success: (rate) {
                            eventRate = rate.eventRate ?? 0.0;
                            parkingRate = rate.parkingRate ?? 0.0;
                          },
                          failed: () {},
                        );

                        print("eventRate $eventRate  parkingRate $parkingRate");

                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30.0)),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          builder: (context) => RateContent(
                            reservation: widget.reservation,
                            eventRate: eventRate,
                            parkingRate: parkingRate,
                          ),
                        );

                        setState(() {
                          checkRateState = ref.watch(checkRateNotifierProvider);
                        });
                      } else {
                        AutoRouter.of(context)
                            .push(TimerRoute(reservation: widget.reservation));
                      }
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
                          widget.reservation.state != "ended"
                              ? "View Timer"
                              : checkRateState is Failed
                                  ? "Give Rate"
                                  : "Modify Your Vote",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      print("widget.reservation");

                      print(widget.reservation.vehicle);
                      AutoRouter.of(context)
                          .push(TicketRoute(reservation: widget.reservation));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      color: const Color.fromARGB(255, 145, 159, 241),
                      child: const Center(
                        child: Text(
                          "View Ticket",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
