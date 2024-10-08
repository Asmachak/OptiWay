import 'package:flutter/material.dart';
import 'package:front/features/reservation/data/models/reservation/reservation_model.dart';

class TransactionCard extends StatelessWidget {
  final ReservationModel reservation;
  final VoidCallback onReport; // Add a callback for reporting the transaction

  const TransactionCard({
    Key? key,
    required this.reservation,
    required this.onReport, // Add the required callback here
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.indigo, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date and Time
              Text(
                "${reservation.CreatedAt.toString().split("T")[0]} ${reservation.CreatedAt.toString().split("T")[1].split(".")[0]}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 122, 122, 122),
                ),
              ),
              const SizedBox(height: 8),
              // Service Row
              Row(
                children: [
                  const Text(
                    'Service:  ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 39, 50, 103),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Payment Parking ${reservation.ReservationParking!["parking"]["parkingName"]}" +
                          (reservation.ReservationEvent != null
                              ? " && Event ${reservation.ReservationEvent!["event"]["title"]}"
                              : ""),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Amount Row
              Row(
                children: [
                  const Text(
                    'Amount: ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 39, 50, 103),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      ' ${reservation.amount} Euro',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Report Icon
          Positioned(
            top: -15,
            right: -10,
            child: IconButton(
              icon: const Icon(Icons.report),
              color: Colors.red,
              onPressed: onReport, // Handle the report action
            ),
          ),
        ],
      ),
    );
  }
}
