import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart' as carouselSlider;
import 'package:flutter/material.dart';
import 'package:front/features/parking/data/models/parking_model.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:geolocator/geolocator.dart';

double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const p = 0.017453292519943295; // Math.PI / 180
  var c = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(c)); // 2 * R; R = 6371 km
}

class ParkingCarousel extends StatelessWidget {
  final List<ParkingModel> filteredParkings;
  final Position? currentPosition;

  const ParkingCarousel(
      {Key? key, required this.filteredParkings, required this.currentPosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of image paths
    final List<String> imagePaths = [
      'assets/parking.jpg',
      'assets/parking2.jpg',
      'assets/parking3.jpg',
      'assets/parking4.jfif',
      // Add more paths as needed
    ];

    return carouselSlider.CarouselSlider(
      options: carouselSlider.CarouselOptions(
        height: 300.0, // Adjust height to ensure it fits the content
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: filteredParkings.asMap().entries.map((entry) {
        int index = entry.key;
        ParkingModel parking = entry.value;

        // Select the image path based on the index
        String imagePath = imagePaths[index % imagePaths.length];

        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                      child: Image.asset(
                        imagePath,
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                parking.parkingName!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                parking.adress!,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "\$20/per hour",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.w500),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Distance: ${_calculateDistance(
                                          currentPosition!.latitude,
                                          currentPosition!.longitude,
                                          double.parse(parking.location!
                                              .split(',')[0]
                                              .trim()),
                                          double.parse(parking.location!
                                              .split(',')[1]
                                              .trim()),
                                        ).toStringAsFixed(1)} km",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      AutoRouter.of(context).push(
                                          ParkingDetailsRoute(
                                              parking: parking));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.indigo, // Button color
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      shadowColor: Colors.black, // Shadow color
                                      elevation: 5.0, // Shadow elevation
                                    ),
                                    child: const Text(
                                      "Book Now",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
