import 'package:flutter/material.dart';

class ParkingWidget extends StatelessWidget {
  const ParkingWidget({
    Key? key,
    required this.title,
    required this.adress, // Add photoUrl parameter for the image URL
  }) : super(key: key);

  final String title;
  final String adress; // Define the photoUrl variable

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            width: double.maxFinite,
            height: 140,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 149, 160, 214).withOpacity(0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 120, // Adjust the width of the photo container
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://www.shutterstock.com/image-vector/car-parking-icon-space-lot-260nw-1024735732.jpg"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 8), // Add some spacing between the photo and text
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 35, 42, 83)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2, // Set maximum lines for the text
                          ),
                          const SizedBox(
                              height: 4), // Add some vertical spacing
                          Text(
                            adress,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
