import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:front/features/event/data/models/movie/movie_model.dart';
import 'package:front/features/event/presentation/widgets/timinigs_list.dart';
import 'package:front/features/paiement/presentation/blocs/paiement_provider.dart';
import 'package:front/features/promo/presentation/blocs/check_promo_provider.dart';
import 'package:front/features/promo/presentation/blocs/state/check_promo_state/check_promo_state.dart';
import 'package:front/features/reservation/presentation/blocs/jsonDataProvider.dart';
import 'package:front/features/reservation/presentation/blocs/reservationEvent_provider.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservationEvent/reservationEvent_state.dart'
    as reservationEvent_state;
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:get_it/get_it.dart';
import 'package:front/features/event/presentation/widgets/cart_stepper.dart'
    as stepper;
import 'package:google_maps_flutter/google_maps_flutter.dart';

@RoutePage()
class MovieDetailCinemaScreen extends ConsumerStatefulWidget {
  final MovieModel movie;
  final String cinema;

  const MovieDetailCinemaScreen({
    Key? key,
    required this.cinema,
    required this.movie,
  }) : super(key: key);

  @override
  _MovieDetailCinemaScreenState createState() =>
      _MovieDetailCinemaScreenState();
}

class _MovieDetailCinemaScreenState
    extends ConsumerState<MovieDetailCinemaScreen> {
  List<List<dynamic>>? parkings;
  List<Map<String, dynamic>>? timings;
  Future<LatLng>? cinemaLatLngFuture;
  Set<Marker> markers = {};
  LatLngBounds? bounds;
  int? selectedParkingIndex;
  int? globalSelectedTimingIndex;
  Map<String, int> selectedTimingIndices = {};
  late dynamic json;
  late dynamic jsonData;

  @override
  void initState() {
    super.initState();
    json = ref.read(reservationEventDataProvider);
    jsonData = ref.read(reservationParkingDataProvider);

    json["idevent"] = widget.movie.id;
    jsonData["idevent"] = widget.movie.id;

    cinemaLatLngFuture = _initializeCinemaLatLng();

    // Fetch promo details
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(checkpromoNotifierProvider.notifier).checkPromo(widget.movie.id);
    });
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

      _extractCinemaData(cinema);

      final cinemaAddress = cinema['address'];
      if (cinemaAddress == null || cinemaAddress.length < 2) {
        throw Exception('Invalid address format');
      }

      return LatLng(cinemaAddress[0], cinemaAddress[1]);
    } catch (e) {
      debugPrint('Error initializing cinema location: $e');
      return const LatLng(0, 0);
    }
  }

  void _extractCinemaData(dynamic cinema) {
    final extractedParkings = cinema['parkings'];
    final extractedDates = cinema['dates'];

    timings = (extractedDates is List &&
            extractedDates.every((e) => e is Map<String, dynamic>))
        ? extractedDates.cast<Map<String, dynamic>>()
        : [];

    parkings =
        (extractedParkings is List && extractedParkings.every((e) => e is List))
            ? extractedParkings.cast<List<dynamic>>()
            : [];

    if (parkings != null && parkings!.isNotEmpty) {
      _createParkingMarkers();
    }
  }

  void _createParkingMarkers() {
    final List<LatLng> allParkingLatLngs = [];

    if (json["parking"] == "" && jsonData["idparking"] == "") {
      for (var parking in parkings!) {
        _addParkingMarker(parking, allParkingLatLngs);
      }
    } else {
      for (var parking in parkings!) {
        if (parking[0] == jsonData["parking"]) {
          _addParkingMarker(parking, allParkingLatLngs);
          break;
        }
      }
    }

    if (allParkingLatLngs.isNotEmpty) {
      _calculateBounds(allParkingLatLngs);
    }
  }

  void _addParkingMarker(
      List<dynamic> parking, List<LatLng> allParkingLatLngs) {
    final parkingName = parking[0];
    final parkingCoordinates = parking[2];
    final parkingLatLng = LatLng(parkingCoordinates[0], parkingCoordinates[1]);

    markers.add(
      Marker(
        markerId: MarkerId(parkingName),
        position: parkingLatLng,
        infoWindow: InfoWindow(title: parkingName),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );

    allParkingLatLngs.add(parkingLatLng);
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

  double _calculateFinalPrice(CheckPromoState promoState) {
    int numberOfTickets = jsonData['idparking'] == ""
        ? (json["Nbreticket"] ?? 0)
        : (jsonData["Nbreticket"] ?? 0);
    double ticketPrice = 6.0; // Assuming each ticket costs 6
    double totalPrice = numberOfTickets * ticketPrice;
    double discountedPrice = totalPrice;

    if (promoState is Success) {
      final promo = promoState.promo;
      if (promo.percentageEvent != null) {
        double discount = promo.percentageEvent! / 100;
        discountedPrice = totalPrice * (1 - discount);
      }
    }

    return discountedPrice;
  }

  @override
  Widget build(BuildContext context) {
    double heightScr = MediaQuery.of(context).size.height;

    final paiementState = ref.watch(paiementNotifierProvider);
    final promoState = ref.watch(checkpromoNotifierProvider);

    double finalPrice = _calculateFinalPrice(promoState);

    // Listening to the ReservationEventState
    ref.listen<reservationEvent_state.ReservationEventState>(
      reservationEventNotifierProvider,
      (previous, next) {
        if (next is reservationEvent_state.Success) {
          // Navigate to the reservations list on success
          AutoRouter.of(context).replace(ReservationListRoute());
          resetReservationProviders(ref);
        }
      },
    );

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
            _addCinemaMarker(cinemaLatLng);

            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildGoogleMap(heightScr, cinemaLatLng),
                  if (jsonData["idparking"] == "" &&
                      json["idparking"] == "") ...[
                    _buildParkingSelection(),
                  ],
                  _buildEventTimeSelection(),
                  if (globalSelectedTimingIndex != null && timings != null)
                    TimingList(
                      key: UniqueKey(),
                      date: timings![globalSelectedTimingIndex!]['date'],
                      timingList: timings![globalSelectedTimingIndex!]
                          ['timings'],
                      selectedTimingIndices: selectedTimingIndices,
                    ),
                  _buildTicketsSelection(promoState),
                  if (jsonData["idparking"] == "" && json["idevent"] != "") ...[
                    _buildSelectCarButton(context, finalPrice),
                  ] else ...[
                    _buildPaymentButton(context, paiementState),
                  ],
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _addCinemaMarker(LatLng cinemaLatLng) {
    markers.add(
      Marker(
        markerId: MarkerId(widget.cinema),
        position: cinemaLatLng,
        infoWindow: InfoWindow(title: widget.cinema),
      ),
    );
  }

  Widget _buildGoogleMap(double heightScr, LatLng cinemaLatLng) {
    return Padding(
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
              Future.delayed(const Duration(milliseconds: 500), () {
                if (bounds != null) {
                  controller.animateCamera(
                    CameraUpdate.newLatLngBounds(bounds!, 50),
                  );
                } else {
                  controller.showMarkerInfoWindow(MarkerId(widget.cinema));
                }
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildParkingSelection() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "Choose where you want to park your car",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 2.5, // Adjusted to make the container taller
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
                  setState(() {
                    selectedParkingIndex = index;
                  });
                  json["parking"] = parkingName;
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            parkingName,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${parkingDistance.toStringAsFixed(2)} km',
                            style: const TextStyle(
                              fontSize: 14.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEventTimeSelection() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "Choose when you will attend the event",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
      ],
    );
  }

  Widget _buildTicketsSelection(CheckPromoState promoState) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            "Tickets Number",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Center(
          child: stepper.CartStepperInt(
            initialValue: 0,
            minValue: 0,
            maxValue: 50,
            onChanged: (value) {
              if (jsonData['idparking'] == "") {
                json["Nbreticket"] = value;
              } else {
                jsonData["Nbreticket"] = value;
              }
              setState(() {}); // Trigger UI update to reflect the new price
            },
          ),
        ),
        const SizedBox(height: 10),
        _buildPromoAndPrice(promoState), // Display promo and ticket price
      ],
    );
  }

  Widget _buildPromoAndPrice(CheckPromoState promoState) {
    int numberOfTickets = jsonData['idparking'] == ""
        ? (json["Nbreticket"] ?? 0)
        : (jsonData["Nbreticket"] ?? 0);
    double ticketPrice = 6.0; // Assuming each ticket costs 6
    double totalPrice = numberOfTickets * ticketPrice;
    double discountedPrice = totalPrice;

    if (promoState is Success) {
      final promo = promoState.promo;
      if (promo.percentageEvent != null) {
        double discount = promo.percentageEvent! / 100;
        discountedPrice = totalPrice * (1 - discount);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.indigo.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (promoState is Success &&
                promoState.promo.percentageEvent != null)
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Text(
                  "Promo Applied: ${promoState.promo.percentageEvent?.toInt()}% off",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ticket Price",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "$ticketPrice € per ticket",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.indigo.shade700,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${discountedPrice.toStringAsFixed(2)} €",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade900,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectCarButton(BuildContext context, double finalPrice) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () {
            AutoRouter.of(context).push(
                VehiculeListReservationEventRoute(finalPrice: finalPrice));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.indigo),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide.none,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Select a car",
              style: TextStyle(
                fontSize: 18,
                color: Colors.indigo.shade50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentButton(BuildContext context, dynamic paiementState) {
    return Center(
      child: TextButton(
        onPressed: () async {
          print("Go to Payment");
          final numberOfTickets;
          // Ensure json["Nbreticket"] is not null before performing multiplication
          if (jsonData["idparking"] == "") {
            numberOfTickets = json["Nbreticket"];
          } else {
            numberOfTickets = jsonData["Nbreticket"];
          }
          if (numberOfTickets == 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please select the number of tickets')),
            );
            return;
          }

          ref.read(paiementNotifierProvider.notifier).initPaymentSheet(
              {"amount": numberOfTickets * 6, "currency": "eur"});

          paiementState.when(
            initial: () {
              SizedBox();
            },
            loading: () => CircularProgressIndicator(),
            success: (paymentModel) async {
              await _processPayment(context, paymentModel);
            },
            failure: (error) => Text('Error: ${error.message}'),
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.indigo),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide.none,
            ),
          ),
        ),
        child: Text(
          "Go to Payment",
          style: TextStyle(
            fontSize: 18,
            color: Colors.indigo.shade50,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> _processPayment(
      BuildContext context, dynamic paymentModel) async {
    Stripe.publishableKey = paymentModel.publishableKey;
    BillingDetails billingDetails = BillingDetails(
      address: Address(
        country: 'BE',
        city: GetIt.instance.get<AuthLocalDataSource>().currentUser!.city!,
        line1: 'addr1',
        line2: 'addr2',
        postalCode: '1000',
        state: 'bruxelle',
      ),
    );

    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customFlow: false,
          merchantDisplayName: 'MOBIZATE',
          paymentIntentClientSecret: paymentModel.paymentIntent,
          customerEphemeralKeySecret: paymentModel.ephemeralKey,
          customerId: paymentModel.customer,
          billingDetails: billingDetails,
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'BE',
            currencyCode: 'eur',
            testEnv: true,
          ),
        ),
      );
      print("Payment sheet initialized successfully");

      await Stripe.instance.presentPaymentSheet();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment Successful')),
      );
      final lastjson;

      if (jsonData["idparking"] == "" && json["parking"] != "") {
        lastjson = json;
      } else {
        lastjson = jsonData;
      }

      lastjson["iduser"] =
          GetIt.instance.get<AuthLocalDataSource>().currentUser?.id;
      print(lastjson);

      await ref
          .read(reservationEventNotifierProvider.notifier)
          .addReservationEvent(
            lastjson,
            lastjson["iduser"],
            lastjson["idvehicule"],
            lastjson["idevent"],
          );

      if (ref.watch(reservationEventNotifierProvider) is Success) {
        resetReservationProviders(ref);

        AutoRouter.of(context).replace(ReservationListRoute());
      }
    } catch (e) {
      print("Error presenting payment sheet: $e");
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.error.localizedMessage}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}
