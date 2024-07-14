import 'package:flutter/material.dart';
import 'package:front/features/reservation/data/models/reservation_model.dart';

class TransactionCard extends StatelessWidget {
  final ReservationModel reservation;
  const TransactionCard({Key? key, required this.reservation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.indigo, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${reservation.createdAt.toString().split("T")[0]} ${reservation.createdAt.toString().split("T")[1].split(".")[0]}",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 122, 122, 122)),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                'Service:  ',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 39, 50, 103)),
              ),
              Text("Payment Parking ${reservation.parking!["parkingName"]}"),
              if (reservation.idevent != null)
                Text("&& Event ${reservation.idevent}")
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Montant: ',
                style: const TextStyle(
                  color: Color.fromARGB(255, 39, 50, 103),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ' -${reservation.amount} Euro',
                style: const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
