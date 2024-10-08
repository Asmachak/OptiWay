import 'package:auto_route/auto_route.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:front/features/reservation/data/models/reservation/reservation_model.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_widget/ticket_widget.dart';

@RoutePage()
class TicketScreen extends ConsumerWidget {
  TicketScreen({super.key, required this.reservation});
  ReservationModel reservation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text("Reservation Ticket"),
      ),
      body: SingleChildScrollView(
        child: TicketReservation(reservation: reservation),
      ),
    );
  }
}

class TicketReservation extends ConsumerStatefulWidget {
  TicketReservation({Key? key, required this.reservation}) : super(key: key);
  final ReservationModel reservation;

  @override
  _TicketReservationState createState() => _TicketReservationState();
}

class _TicketReservationState extends ConsumerState<TicketReservation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthScr = MediaQuery.of(context).size.width;
    double heightScr = MediaQuery.of(context).size.height;

    DateTime dateTimeEnd =
        DateTime.parse(widget.reservation.EndedAt!).toLocal();
    DateTime dateTimeCreate =
        DateTime.parse(widget.reservation.CreatedAt!).toLocal();

    Duration duration = dateTimeEnd.difference(dateTimeCreate);

    String formatDuration(Duration duration) {
      int days = duration.inDays;
      int hours = duration.inHours.remainder(24);
      int minutes = duration.inMinutes.remainder(60);
      return '${days}d${hours}h${minutes}min';
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: TicketWidget(
              height: heightScr * 0.91,
              width: widthScr * 0.9,
              isCornerRounded: true,
              color: const Color.fromARGB(255, 241, 241, 246),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Scan this Code on the scanner machine when you are in the parking or event",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 37, 45, 91),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: QrImageView(
                        data: widget.reservation.id!,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    ),
                    const SizedBox(height: 45),
                    const DottedLine(
                      dashLength: 5,
                      dashGapLength: 9,
                      lineThickness: 2,
                      dashColor: Colors.grey,
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
                                  "Paiement amount",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 19,
                                  ),
                                ),
                                Text(
                                  "${widget.reservation.amount.toString()} Euro",
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
                                  "area A2", // Replace with actual data
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
                                  "Duration",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 19,
                                  ),
                                ),
                                Text(
                                  formatDuration(duration),
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
                                  "Date",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 19,
                                  ),
                                ),
                                Text(
                                  DateTime.parse(widget.reservation.EndedAt!)
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
                                  "Hour",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 19,
                                  ),
                                ),
                                Text(
                                  "${DateTime.parse(widget.reservation.CreatedAt!).toLocal().toString().split(" ")[1].substring(0, 5)} - ${DateTime.parse(widget.reservation.EndedAt!).toLocal().toString().split(" ")[1].substring(0, 5)}",
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
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context)
                      .push(GetDirectionRoute(reservation: widget.reservation));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    side: BorderSide.none,
                    shape: const StadiumBorder()),
                child: const Text("Get Direction",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 255, 255))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
