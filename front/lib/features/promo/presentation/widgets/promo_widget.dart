import 'package:flutter/material.dart';
import 'package:front/features/promo/data/models/promo_model.dart';

class PromoWidget extends StatelessWidget {
  final PromoModel promo;

  const PromoWidget({Key? key, required this.promo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 137, 149, 198),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          // Left side with promo text
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Promo Title
                  Text(
                    promo.title ?? "Free shipping!",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 7, 11, 71), // Text color
                    ),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    "Event discount ${promo.percentageEvent!.toInt()}%",
                    style: const TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(255, 231, 231, 239), // Text color
                    ),
                  ),
                  Text(
                    "Parking discount ${promo.percentageParking!.toInt()}%",
                    style: const TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(255, 231, 231, 239), // Text color
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right side with product image
          Container(
            width: MediaQuery.of(context).size.width *
                0.5, // Set width to 50% of screen width
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              child: Image.network(
                promo.event!['image_url'] ??
                    'https://via.placeholder.com/100', // Replace with actual image URL from promo model
                fit: BoxFit.cover, // Cover the space, maintaining aspect ratio
                height: double
                    .infinity, // Make sure the image takes up full height of its parent
              ),
            ),
          ),
        ],
      ),
    );
  }
}
