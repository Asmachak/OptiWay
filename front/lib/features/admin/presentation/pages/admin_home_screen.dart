import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/admin/data/data_sources/admin_local_data_src.dart';
import 'package:front/features/parking/data/models/parking_model.dart';
import 'package:front/features/parking/presentation/blocs/parking_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:permission_handler/permission_handler.dart';

@RoutePage()
class AdminHomeScreen extends ConsumerStatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends ConsumerState<AdminHomeScreen> {
  late GoogleMapController mapController;
  Position? _currentPosition;
  bool _isLoadingLocation = true;
  BitmapDescriptor? _parkingMarkerIcon;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(parkingNotifierProvider.notifier).getParkings();
      _getCurrentLocation();
      _loadCustomMarker();
      _requestLocationPermission();
    });
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isDenied) {
      // Handle the case where the user denies location permissions.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location permission is denied.'),
        ),
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
        _isLoadingLocation = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingLocation = false;
      });
      print("Error getting current location: $e");
    }
  }

  Future<void> _loadCustomMarker() async {
    final Uint8List markerIcon = await _getBytesFromAsset(
      'assets/parking_marker.png', // Path to your asset
      100, // Desired width in pixels
    );
    setState(() {
      _parkingMarkerIcon = BitmapDescriptor.fromBytes(markerIcon);
    });
  }

  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Set<Marker> _createMarkers(List<ParkingModel> parkings) {
    Set<Marker> markers = {};

    if (_currentPosition != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position:
              LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          infoWindow: const InfoWindow(title: 'Current Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }

    for (var parking in parkings) {
      if (parking.location != null && parking.location!.isNotEmpty) {
        final coords = parking.location!.split(',');
        if (coords.length == 2) {
          final lat = double.tryParse(coords[0].trim());
          final lng = double.tryParse(coords[1].trim());
          if (lat != null && lng != null) {
            markers.add(
              Marker(
                markerId: MarkerId(parking.parkingName!),
                position: LatLng(lat, lng),
                infoWindow: InfoWindow(title: parking.parkingName),
                icon: _parkingMarkerIcon ??
                    BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue),
              ),
            );
          }
        }
      }
    }
    return markers;
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295; // Math.PI / 180
    var c = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(c)); // 2 * R; R = 6371 km
  }

  List<ParkingModel> _getClosestParkings(List<ParkingModel> parkings) {
    if (_currentPosition == null) return [];

    parkings.sort((a, b) {
      final aCoords = a.location!.split(',');
      final bCoords = b.location!.split(',');
      final aLat = double.parse(aCoords[0].trim());
      final aLng = double.parse(aCoords[1].trim());
      final bLat = double.parse(bCoords[0].trim());
      final bLng = double.parse(bCoords[1].trim());
      final aDistance = _calculateDistance(
          _currentPosition!.latitude, _currentPosition!.longitude, aLat, aLng);
      final bDistance = _calculateDistance(
          _currentPosition!.latitude, _currentPosition!.longitude, bLat, bLng);
      return aDistance.compareTo(bDistance);
    });

    return parkings.take(8).toList();
  }

  @override
  Widget build(BuildContext context) {
    final authLocalDataSource = GetIt.instance.get<AdminLocalDataSource>();
    final currentUser = authLocalDataSource.currentAdmin!;
    final userName =
        currentUser.name![0].toUpperCase() + currentUser.name!.substring(1);
    final parkingState = ref.watch(parkingNotifierProvider);
    return Scaffold(
      body: Stack(
        children: [
          // Google Map Background
          if (_isLoadingLocation)
            const Center(child: CircularProgressIndicator())
          else
            parkingState.when(
              initial: () => const Center(child: Text("Initializing...")),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (parkings) {
                final filteredParkings = _getClosestParkings(parkings
                    .where((parking) => parking.location!.isNotEmpty)
                    .toList());

                if (filteredParkings.isEmpty) {
                  return const Center(
                      child: Text("No available parkings with addresses."));
                }

                return GoogleMap(
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_currentPosition!.latitude,
                        _currentPosition!.longitude),
                    zoom: 12.5,
                  ),
                  markers: _createMarkers(filteredParkings),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                );
              },
              failure: (error) =>
                  Center(child: Text("Error: ${error.message}")),
              success: () => const Center(child: Text("Operation Successful")),
            ),
          // Floating Action Buttons for Map Controls
          Positioned(
            top: 20.0,
            right: 10.0,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'btn1',
                  mini: true,
                  onPressed: () {
                    mapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(_currentPosition!.latitude,
                              _currentPosition!.longitude),
                          zoom: 14,
                        ),
                      ),
                    );
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.my_location, color: Colors.black),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'btn2',
                  mini: true,
                  onPressed: () {
                    // Your action for map layers
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.layers, color: Colors.black),
                ),
              ],
            ),
          ),
          // Draggable Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            maxChildSize: 0.6,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, $userName',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the content horizontally
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center the content vertically
          children: [
            Icon(icon, size: 38, color: Colors.indigo),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.aBeeZee(
                textStyle: const TextStyle(
                  fontSize: 25,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
