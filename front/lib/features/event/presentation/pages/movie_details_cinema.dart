import 'package:flutter/material.dart';
import 'package:front/features/event/data/models/movie/movie_model.dart';
import 'package:front/features/event/presentation/widgets/button_row.dart';
import 'package:front/features/event/presentation/widgets/timinigs_list.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:front/features/event/presentation/widgets/cart_stepper.dart'
    as stepper;

class MovieDetailCinemaScreen extends StatefulWidget {
  final MovieModel movie;
  final String cinema;

  const MovieDetailCinemaScreen({
    Key? key,
    required this.cinema,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieDetailCinemaScreen> createState() =>
      _MovieDetailCinemaScreenState();
}

class _MovieDetailCinemaScreenState extends State<MovieDetailCinemaScreen> {
  List<List<dynamic>>? parkings;
  List<Map<String, dynamic>>? timings;
  Future<LatLng>? cinemaLatLngFuture;
  Set<Marker> markers = {};
  LatLngBounds? bounds;
  int? selectedParkingIndex;
  int? globalSelectedTimingIndex;
  Map<String, int> selectedTimingIndices =
      {}; // Define selectedTimingIndices here

  @override
  void initState() {
    super.initState();
    cinemaLatLngFuture = _initializeCinemaLatLng();
  }

  Future<LatLng> _initializeCinemaLatLng() async {
    try {
      final cinema = widget.movie.cinemas.firstWhere(
        (cinema) => cinema['name'] == widget.cinema,
        orElse: () => null,
      );

      if (cinema == null) {
        throw Exception('Cinema not found');
      }

      final extractedParkings = cinema['parkings'];
      final cinemaAddress = cinema['address'];
      final extractedDates = cinema['dates'];

      if (extractedDates is List &&
          extractedDates.every((e) => e is Map<String, dynamic>)) {
        timings = extractedDates.cast<Map<String, dynamic>>();
      } else {
        timings = [];
      }

      if (extractedParkings is List &&
          extractedParkings.every((e) => e is List)) {
        parkings = extractedParkings.cast<List<dynamic>>();

        _createParkingMarkers();
      } else {
        parkings = [];
      }

      if (cinemaAddress == null || cinemaAddress.length < 2) {
        throw Exception('Invalid address format');
      }

      return LatLng(
        cinemaAddress[0],
        cinemaAddress[1],
      );
    } catch (e) {
      debugPrint('Error initializing cinema location: $e');
      return const LatLng(0, 0);
    }
  }

  void _createParkingMarkers() {
    if (parkings != null) {
      final List<LatLng> allParkingLatLngs = [];

      for (var parking in parkings!) {
        final parkingName = parking[0];
        final parkingCoordinates = parking[2];
        final parkingLatLng =
            LatLng(parkingCoordinates[0], parkingCoordinates[1]);

        markers.add(
          Marker(
            markerId: MarkerId(parkingName),
            position: parkingLatLng,
            infoWindow: InfoWindow(title: parkingName),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
          ),
        );

        allParkingLatLngs.add(parkingLatLng);
      }

      if (allParkingLatLngs.isNotEmpty) {
        _calculateBounds(allParkingLatLngs);
      }
    }
  }

  void _calculateBounds(List<LatLng> latLngs) {
    final boundsBuilder = LatLngBounds(
      southwest: LatLng(
        latLngs
            .map((latLng) => latLng.latitude)
            .reduce((a, b) => a < b ? a : b),
        latLngs
            .map((latLng) => latLng.longitude)
            .reduce((a, b) => a < b ? a : b),
      ),
      northeast: LatLng(
        latLngs
            .map((latLng) => latLng.latitude)
            .reduce((a, b) => a > b ? a : b),
        latLngs
            .map((latLng) => latLng.longitude)
            .reduce((a, b) => a > b ? a : b),
      ),
    );

    setState(() {
      bounds = boundsBuilder;
    });
  }

  @override
  Widget build(BuildContext context) {
    double heightScr = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Reserve for the Events'),
      ),
      body: FutureBuilder<LatLng>(
        future: cinemaLatLngFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == const LatLng(0, 0)) {
            return const Center(child: Text('Failed to load cinema location'));
          } else {
            final cinemaLatLng = snapshot.data!;
            markers.add(
              Marker(
                markerId: MarkerId(widget.cinema),
                position: cinemaLatLng,
                infoWindow: InfoWindow(title: widget.cinema),
              ),
            );

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: SizedBox(
                        height: heightScr * 0.3,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: cinemaLatLng,
                            zoom: 17,
                          ),
                          markers: markers,
                          onMapCreated: (GoogleMapController controller) {
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              if (bounds != null) {
                                controller.animateCamera(
                                  CameraUpdate.newLatLngBounds(bounds!, 50),
                                );
                              } else {
                                controller.showMarkerInfoWindow(
                                    MarkerId(widget.cinema));
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Choose where you want to park your car",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 3.0,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: parkings?.length ?? 0,
                      itemBuilder: (context, index) {
                        final parking = parkings![index];
                        final parkingName = parking[0];
                        final parkingDistance = parking[1];
                        final isSelected = selectedParkingIndex == index;

                        return GestureDetector(
                          onTap: () {
                            // Handle onTap action here
                            setState(() {
                              selectedParkingIndex = index;
                            });
                            print('Parking $parkingName tapped');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color.fromARGB(255, 192, 214, 232)
                                    : Colors.grey[200],
                                border: Border.all(
                                  color: isSelected
                                      ? const Color.fromARGB(255, 136, 188, 231)
                                      : Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: Text(
                                  '$parkingName/n${parkingDistance.toStringAsFixed(2)} km',
                                  style: const TextStyle(fontSize: 16.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Choose when you will attend the event",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: timings?.length ?? 0,
                      itemBuilder: (context, index) {
                        final date = timings![index]['date'];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              globalSelectedTimingIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                date,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: globalSelectedTimingIndex == index
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (globalSelectedTimingIndex != null && timings != null)
                    TimingList(
                      key:
                          UniqueKey(), // Ensure each TimingList gets a unique key
                      date: timings![globalSelectedTimingIndex!]['date'],
                      timingList: timings![globalSelectedTimingIndex!]
                          ['timings'],
                      selectedTimingIndices:
                          selectedTimingIndices, // Pass selectedTimingIndices here
                    ),
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Tickets Number",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Center(
                    child: stepper.CartStepperInt(
                      initialValue: 1,
                      minValue: 1,
                      maxValue: 10,
                      onChanged: (value) {
                        print('Selected value: $value');
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonRow()
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
