import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:front/core/conts.dart';
import 'package:front/features/reservation/data/models/reservation_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

@RoutePage()
class GetDirectionScreen extends StatefulWidget {
  ReservationModel reservation;

  GetDirectionScreen({super.key, required this.reservation});

  @override
  State<GetDirectionScreen> createState() => _GetDirectionScreenState();
}

class _GetDirectionScreenState extends State<GetDirectionScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  List<LatLng> polylineCoordinates = [];
  Position? currentLocation;
  var latitude;
  var longitude;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isDenied) {
      print('User denied location permissions');
    } else if (status.isGranted) {
      getCurrentLocation();
    }
  }

  Future<void> _parseLocation(String location, String address) async {
    try {
      if (location.isEmpty) {
        List<Location> locations = await locationFromAddress(address);
        setState(() {
          latitude = locations[0].latitude;
          longitude = locations[0].longitude;
        });
      } else {
        List<String> locationParts = location.split(', ');
        setState(() {
          latitude = double.parse(locationParts[0]);
          longitude = double.parse(locationParts[1]);
        });
      }
    } catch (e) {
      debugPrint('Error parsing location: $e');
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentLocation = currentPosition;
        getPolyPoints();
      });
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        GOOGLE_MAPS_API_KEY,
        PointLatLng(currentLocation!.latitude, currentLocation!.longitude),
        PointLatLng(latitude, longitude));

    if (result.points.isNotEmpty) {
      setState(() {
        polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      });
    } else {
      print('No polyline points found');
    }
  }

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    _parseLocation(widget.reservation.parking!['location'],
        widget.reservation.parking!['adress']);
    //setCustomMarkerICon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Destination"),
      ),
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentLocation!.latitude, currentLocation!.longitude),
                  zoom: 9.3),
              polylines: {
                Polyline(
                    polylineId: const PolylineId("route"),
                    points: polylineCoordinates,
                    color: const Color.fromARGB(255, 27, 107, 172),
                    width: 6)
              },
              markers: {
                Marker(
                    markerId: const MarkerId("source"),
                    // icon: sourceIcon,
                    position: LatLng(
                        currentLocation!.latitude, currentLocation!.longitude)),
                Marker(
                    markerId: const MarkerId("destination"),
                    position: LatLng(latitude, longitude)),
                Marker(
                    markerId: const MarkerId("currentLocation"),
                    position: LatLng(
                        currentLocation!.latitude, currentLocation!.longitude)),
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
    );
  }
}
