import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' as flutter_html;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/loading.dart';
import 'package:front/features/parking/data/models/parking_model.dart';
import 'package:front/features/reservation/presentation/blocs/jsonDataProvider.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class ParkingDetailsScreen extends ConsumerWidget {
  const ParkingDetailsScreen({Key? key, required this.parking})
      : super(key: key);

  final ParkingModel parking;

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isDenied) {
      // Handle denied permission
      print('User denied location permissions');
    }
  }

  Future<LatLng> parseLocation(String? location, String? address) async {
    try {
      await requestLocationPermission();

      if (location == null || location.isEmpty) {
        if (address == null || address.isEmpty) {
          // Return a default location if both location and address are unavailable
          return const LatLng(0, 0);
        }
        List<geocoding.Location> locations =
            await geocoding.locationFromAddress(address);
        double latitude = locations[0].latitude;
        double longitude = locations[0].longitude;

        return LatLng(latitude, longitude);
      } else {
        List<String> locationParts = location.split(', ');
        double latitude = double.parse(locationParts[0]);
        double longitude = double.parse(locationParts[1]);

        return LatLng(latitude, longitude);
      }
    } catch (e) {
      debugPrint('Error parsing location: $e');
      return const LatLng(0, 0); // Return default location on error
    }
  }

  Future<double> calculateDistance(
      double destLatitude, double destLongitude) async {
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double distance = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      destLatitude,
      destLongitude,
    );
    return distance / 1000; // Convert to kilometers
  }

  void launchCall(String phoneNumber, BuildContext context) async {
    var status = await Permission.phone.request();
    if (status.isGranted) {
      String url = 'tel:$phoneNumber';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not launch phone dialer'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phone call permission not granted'),
        ),
      );
    }
  }

  void launchEmail(String email, BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      debugPrint('Could not launch email client for $email');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open email client'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double heightScr = MediaQuery.of(context).size.height;

    return FutureBuilder<LatLng>(
      future: parseLocation(parking.location, parking.adress),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget();
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Parking Details'),
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          LatLng parkingLatLng = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  resetReservationProviders(ref);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              title: Text(parking.parkingName ?? 'Parking Details'),
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
                              infoWindow:
                                  InfoWindow(title: parking.parkingName),
                            ),
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          parking.parkingName ?? 'Unnamed Parking',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: "Poppins"),
                        ),
                        Text(
                          parking.adress ?? 'No Address Provided',
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: "Poppins",
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder<double>(
                    future: calculateDistance(
                        parkingLatLng.latitude, parkingLatLng.longitude),
                    builder: (context, distanceSnapshot) {
                      String distanceText = 'Calculating...';
                      if (distanceSnapshot.connectionState ==
                          ConnectionState.done) {
                        if (distanceSnapshot.hasError) {
                          distanceText = 'Error';
                        } else {
                          distanceText =
                              '${distanceSnapshot.data!.toStringAsFixed(2)} km';
                        }
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            InfoButton(
                              icon: Icons.room,
                              text: distanceText,
                            ),
                            const SizedBox(width: 10),
                            const InfoButton(
                              icon: Icons.access_time_filled,
                              text: "24h/24 , 7/7",
                            ),
                            const SizedBox(width: 10),
                            InfoButton(
                              icon: Icons.directions_car,
                              text: '${parking.capacity} vehicles',
                            ),
                            const SizedBox(width: 10),
                            if (parking.phoneContact != null)
                              GestureDetector(
                                onTap: () =>
                                    launchCall(parking.phoneContact!, context),
                                child: InfoButton(
                                  icon: Icons.phone,
                                  text: parking.phoneContact!,
                                ),
                              ),
                            const SizedBox(width: 10),
                            if (parking.mailContact != null)
                              GestureDetector(
                                onTap: () =>
                                    launchEmail(parking.mailContact!, context),
                                child: InfoButton(
                                  icon: Icons.mail,
                                  text: parking.mailContact!,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  if (parking.description != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Description",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: "Poppins"),
                          ),
                          flutter_html.Html(
                            data: parking.description!,
                          ),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextButton(
                      onPressed: () {
                        AutoRouter.of(context).push(ReservationRoute(
                            idparking: parking.id!, parking: parking));
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
                        "Make a Reservation",
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

class InfoButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoButton({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            Icon(
              icon,
              color: Colors.indigo,
            ),
            const SizedBox(width: 5),
            Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.indigo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
