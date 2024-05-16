import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart' as flutter_html;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/loading.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class ParkingDetailsScreen extends ConsumerWidget {
  const ParkingDetailsScreen({
    Key? key,
    required this.id,
    required this.parkingName,
    required this.capacity,
    required this.description,
    required this.location,
    required this.phoneContact,
    required this.mailContact,
    required this.adress,
  }) : super(key: key);
  final String id;
  final String parkingName;
  final String location;
  final String description;
  final String capacity;
  final String phoneContact;
  final String mailContact;
  final String adress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var latitude;
    var longitude;

    Future<void> requestLocationPermission() async {
      var status = await Permission.location.request();
      if (status.isDenied) {
        // L'utilisateur a refusé les autorisations
        // Gérez cette situation selon vos besoins
        print('User denied location permissions');
      }
    }

    Future<LatLng> _parseLocation(String location, String adress) async {
      //print("adress $adress");
      print("loc");
      print("location $location");

      try {
        await requestLocationPermission();

        if (location.isEmpty) {
          List<Location> locations = await locationFromAddress(adress);
          latitude = locations[0].latitude;
          longitude = locations[0].longitude;

          LatLng position =
              LatLng(locations[0].latitude, locations[0].longitude);
          return position; // Default location if empty
        }
        List<String> locationParts = location.split(', ');
        latitude = double.parse(locationParts[0]);
        longitude = double.parse(locationParts[1]);

        return LatLng(latitude, longitude);
      } catch (e) {
        debugPrint('Error parsing location: $e');
        return const LatLng(0, 0); // Return default location on error
      }
    }

    Future<String> calculateDistance() async {
      Position currentPosition = await Geolocator.getCurrentPosition();
      double distance = await Geolocator.distanceBetween(
        currentPosition.latitude,
        currentPosition.longitude,
        latitude,
        longitude,
      );
      distance = distance / 1000;
      return distance.toStringAsFixed(2);
    }

    calculateDistance();

    double heightScr = MediaQuery.of(context).size.height;

    void _launchCall(String phoneNumber) async {
      String url = 'tel:$phoneNumber';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        // Handle exception gracefully, e.g., show a snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch $url'),
          ),
        );
      }
    }

    void _launchEmail(String email) async {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: email,
      );

      if (await canLaunch(emailLaunchUri.toString())) {
        await launch(emailLaunchUri.toString());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not Open Mail Box '),
          ),
        );
      }
    }

    // Use a `FutureBuilder` to handle the asynchronous `_parseLocation` method
    return FutureBuilder<LatLng>(
      future: _parseLocation(location, adress),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          LatLng parkingLatLng = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              title: Text(parkingName),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: SizedBox(
                        height: heightScr * 0.3,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: parkingLatLng,
                            zoom: 17,
                          ),
                          markers: {
                            Marker(
                              markerId: const MarkerId('parkingLocation'),
                              position: parkingLatLng,
                              infoWindow: InfoWindow(title: parkingName),
                            ),
                          },
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                      child: Text(
                        parkingName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: "Poppins"),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                      child: Text(
                        adress,
                        style: const TextStyle(
                            fontSize: 15,
                            fontFamily: "Poppins",
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 35,
                          child: FutureBuilder<String>(
                            future: calculateDistance(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(); // Return an empty widget while waiting
                              } else if (snapshot.hasError) {
                                return Text(
                                    'Error: ${snapshot.error}'); // Display error message
                              } else {
                                // Handle nullable String by providing a default value ('N/A' in this case)
                                String distanceText = snapshot.data ?? 'N/A';

                                return OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white10,
                                    side: const BorderSide(
                                      color: Colors.indigo,
                                      width: 2.0,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.room,
                                        color: Colors.indigo,
                                      ),
                                      Text(
                                        "$distanceText km",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.indigo,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 35,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white10,
                              side: const BorderSide(
                                color: Colors.indigo,
                                width: 2.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.access_time_filled,
                                  color: Colors.indigo,
                                ),
                                Text(
                                  "24h/24 , 7/7",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 35,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white10,
                              side: const BorderSide(
                                color: Colors.indigo,
                                width: 2.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.directions_car,
                                  color: Colors.indigo,
                                ),
                                Text(
                                  '$capacity vehicule',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 35,
                          child: OutlinedButton(
                            onPressed: () {
                              _launchCall(phoneContact);
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white10,
                              side: const BorderSide(
                                color: Colors.indigo,
                                width: 2.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  color: Colors.indigo,
                                ),
                                Text(
                                  '$phoneContact',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 35,
                          child: OutlinedButton(
                            onPressed: () {
                              _launchEmail(mailContact);
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white10,
                              side: const BorderSide(
                                color: Colors.indigo,
                                width: 2.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.mail,
                                  color: Colors.indigo,
                                ),
                                Text(
                                  '$mailContact',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                          child: Text(
                            "Description",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                          child: flutter_html.Html(
                            data: description,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextButton(
                      onPressed: () {
                        AutoRouter.of(context)
                            .push(ReservationRoute(idparking: id));
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo[50]),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide.none,
                          ),
                        ),
                      ),
                      child: const Text(
                        "make a reservation",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
