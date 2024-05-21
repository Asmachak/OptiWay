import 'package:auto_route/auto_route.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:front/features/reservation/data/models/reservation_model.dart';
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
          child: TicketReservation(reservation: reservation)),
    );
  }
}

class TicketReservation extends StatefulWidget {
  TicketReservation({Key? key, required this.reservation}) : super(key: key);
  final ReservationModel reservation;
  @override
  State<TicketReservation> createState() => _TicketReservationState();
}

class _TicketReservationState extends State<TicketReservation> {
  @override
  Widget build(BuildContext context) {
    double widthScr = MediaQuery.of(context).size.width;
    double heightScr = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Center(
            child: TicketWidget(
              height: heightScr * 1.1,
              width: widthScr * 0.9,
              isCornerRounded: true,
              color: Colors.indigo.shade50,
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
                          fontSize: 18,
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
                        children: [
                          Column(
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
                                "name",
                                // widget.reservation
                                //     .id!, // Replace with actual data
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Column(
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
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "vehicle",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 19,
                                ),
                              ),
                              Text(
                                "vehicle", // Replace with actual data
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Column(
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
                                'Duration', // Replace with actual data
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
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
                                "Date time", // Replace with actual data
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Column(
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
                                'Hour', // Replace with actual data
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
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
                                'phone', // Replace with actual data
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
