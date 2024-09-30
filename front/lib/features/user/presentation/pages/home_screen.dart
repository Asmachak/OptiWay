import 'dart:math';
import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart'
    as flutter_carousel_widget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/event/presentation/blocs/movie_provider.dart';
import 'package:front/features/parking/data/models/parking_model.dart';
import 'package:front/features/parking/presentation/blocs/parking_provider.dart';
import 'package:front/features/promo/presentation/blocs/promo_provider.dart';
import 'package:front/features/promo/presentation/widgets/promo_widget.dart';
import 'package:front/features/reservation/presentation/blocs/jsonDataProvider.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/user/presentation/widgets/movie_carousel.dart';
import 'package:front/features/user/presentation/widgets/parking_carousel.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'package:permission_handler/permission_handler.dart';

@RoutePage()
class homeScreen extends ConsumerStatefulWidget {
  const homeScreen({super.key});

  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends ConsumerState<homeScreen> {
  late GoogleMapController mapController;
  Position? _currentPosition;
  bool _isLoadingLocation = true;
  BitmapDescriptor? _parkingMarkerIcon;
  late dynamic json;

  @override
  void initState() {
    super.initState();
    json = ref.read(reservationEventDataProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(parkingNotifierProvider.notifier).getParkings();
      ref.read(MovieNotifierProvider.notifier).fetchItems();
      ref.read(promoNotifierProvider.notifier).getPromoList();
      _getCurrentLocation();
      _loadCustomMarker();
      requestLocationPermission();
    });
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

    return parkings.take(4).toList();
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

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isDenied) {
      // L'utilisateur a refusé les autorisations
      // Gérez cette situation selon vos besoins
      print('User denied location permissions');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authLocalDataSource = GetIt.instance.get<AuthLocalDataSource>();
    final currentUser = authLocalDataSource.currentUser!;
    final userName =
        currentUser.name![0].toUpperCase() + currentUser.name!.substring(1);
    final parkingState = ref.watch(parkingNotifierProvider);
    final movieState = ref.watch(MovieNotifierProvider);
    final promoState = ref.watch(promoNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Hello $userName",
                            style: GoogleFonts.aBeeZee(
                              textStyle: const TextStyle(
                                fontSize: 25,
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications_none),
                          color: Colors.indigo,
                          iconSize: 30,
                          onPressed: () {
                            AutoRouter.of(context).push(NotificationRoute());
                          },
                        ),
                      ],
                    ),
                  ),
                  promoState.when(
                    initial: () =>
                        const Center(child: Text("No promotions available.")),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    failure: (error) => Center(child: Text('Error: $error')),
                    loaded: (promos) => SizedBox(
                      height: 140, // Reduced height for the carousel
                      width: MediaQuery.of(context).size.width *
                          200, // Full screen width
                      child: flutter_carousel_widget.FlutterCarousel.builder(
                        itemCount: promos.length,
                        itemBuilder: (context, index, realIndex) {
                          return PromoWidget(promo: promos[index]);
                        },
                        options: flutter_carousel_widget.CarouselOptions(
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: false,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          viewportFraction: 0.99,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                    child: Text(
                      "Where Do You Want To Park?",
                      style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16), // Add some spacing
              if (_isLoadingLocation)
                const Center(child: CircularProgressIndicator())
              else
                parkingState.when(
                  initial: () => const Center(child: Text("Initializing...")),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (parkings) {
                    final filteredParkings = _getClosestParkings(parkings
                        .where((parking) => parking.location!.isNotEmpty)
                        .toList());

                    if (filteredParkings.isEmpty) {
                      return const Center(
                          child: Text("No available parkings with addresses."));
                    }

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: GoogleMap(
                                onMapCreated: (controller) {
                                  mapController = controller;
                                },
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(_currentPosition!.latitude,
                                      _currentPosition!.longitude),
                                  zoom: 12,
                                ),
                                markers: _createMarkers(filteredParkings),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16), // Add some spacing
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Find the perfect spot for your vehicle",
                              style: GoogleFonts.aBeeZee(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ParkingCarousel(
                          filteredParkings: filteredParkings,
                          currentPosition: _currentPosition,
                        ),
                      ],
                    );
                  },
                  failure: (error) =>
                      Center(child: Text("Error: ${error.message}")),
                  success: () =>
                      const Center(child: Text("Operation Successful")),
                ),
              const SizedBox(height: 16), // Add some spacing
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0.0),
                child: Text(
                  "Stay Updated",
                  style: GoogleFonts.aBeeZee(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16), // Add some spacing
              movieState.when(
                initial: () => const Center(child: Text("Initializing...")),
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (moviesList) {
                  return MovieCarousel(moviesList: moviesList);
                },
                failure: (error) =>
                    Center(child: Text("Error: ${error.message}")),
                eventLoaded: (moviesList) =>
                    const Center(child: Text("Event Loaded")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
