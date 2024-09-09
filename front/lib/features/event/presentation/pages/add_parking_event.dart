import 'dart:io';
import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/event/presentation/blocs/event_provider.dart';
import 'package:front/features/event/presentation/blocs/state/event_organiser/event_state.dart';
import 'package:front/features/organiser/data/data_sources/organiser_local_data_src.dart';
import 'package:front/features/paiement/presentation/blocs/paiement_provider.dart';
import 'package:front/features/parking/data/models/parking_model.dart';
import 'package:front/features/parking/presentation/blocs/parking_provider.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class addParkingEventScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> eventData;
  final File image;

  addParkingEventScreen({
    Key? key,
    required this.eventData,
    required this.image,
  }) : super(key: key);

  @override
  _addParkingEventScreenState createState() => _addParkingEventScreenState();
}

class _addParkingEventScreenState extends ConsumerState<addParkingEventScreen> {
  List<ParkingSelection> selectedParkings = [];
  bool isCollaborated = false;
  double totalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    final parkingState = ref.watch(parkingNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Parkings to Collaborate'),
      ),
      body: Column(
        children: [
          Expanded(
            child: parkingState.when(
              initial: initial,
              loading: loading,
              loaded: (parkings) => buildParkingForm(parkings),
              failure: (error) => failure(error.toString()),
              success: success,
            ),
          ),
          if (!isCollaborated) buildCollaborateButton(),
          if (isCollaborated) ...[
            buildInvoiceDetails(),
            buildGoToPaymentButton(),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            selectedParkings.add(ParkingSelection());
          });
        },
        tooltip: 'Add Parking',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget loading() => const Center(child: CircularProgressIndicator());

  Widget initial() =>
      const Center(child: Text("Please wait while loading parkings..."));

  Widget failure(String message) =>
      Center(child: Text("Failed to load parkings: $message"));

  Widget success() =>
      const Center(child: Text("Parkings loaded successfully!"));

  Widget buildParkingForm(List<ParkingModel> parkings) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedParkings.length,
              itemBuilder: (context, index) {
                return buildParkingSelection(index, parkings);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCollaborateButton() {
    return ElevatedButton(
      onPressed: () {
        totalPrice = selectedParkings.fold<double>(
          0.0,
          (sum, parking) =>
              sum + (parking.numberOfPlacesWanted * parking.pricePerPlace),
        );
        List<Map<String, dynamic>> parkingList =
            selectedParkings.map((parking) {
          return {
            'idparking': parking.parkingId,
            'nbre_place': parking.numberOfPlacesWanted.toString(),
            'tarif': parking.pricePerPlace.toStringAsFixed(2),
          };
        }).toList();

        if (selectedParkings.isNotEmpty) {
          setState(() {
            isCollaborated = true;
            widget.eventData['parkings'] = parkingList;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Please select valid parkings and places.')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        backgroundColor: Colors.indigo,
      ),
      child: const Text("Collaborate", style: TextStyle(color: Colors.white)),
    );
  }

  Widget buildGoToPaymentButton() {
    return ElevatedButton(
      onPressed: () async {
        int totalPriceInCents = (totalPrice * 100).round();

        await ref
            .watch(paiementNotifierProvider.notifier)
            .initPaymentSheet({"amount": totalPriceInCents, "currency": "eur"});

        final paiementState = ref.watch(paiementNotifierProvider);

        paiementState.when(
          initial: initial,
          loading: () => const CircularProgressIndicator(),
          success: (paymentModel) async {
            try {
              stripe.Stripe.publishableKey = paymentModel.publishableKey;

              stripe.BillingDetails billingDetails = stripe.BillingDetails(
                address: stripe.Address(
                  country: 'BE',
                  city: GetIt.instance
                      .get<OrganiserLocalDataSource>()
                      .currentOrganiser!
                      .city!,
                  line1: 'addr1',
                  line2: 'addr2',
                  postalCode: '1000',
                  state: 'bruxelle',
                ),
              );

              await stripe.Stripe.instance.initPaymentSheet(
                paymentSheetParameters: stripe.SetupPaymentSheetParameters(
                  customFlow: false,
                  merchantDisplayName: 'MOBIZATE',
                  paymentIntentClientSecret: paymentModel.paymentIntent,
                  customerEphemeralKeySecret: paymentModel.ephemeralKey,
                  customerId: paymentModel.customer,
                  billingDetails: billingDetails,
                  googlePay: const stripe.PaymentSheetGooglePay(
                    merchantCountryCode: 'BE',
                    currencyCode: 'eur',
                    testEnv: true,
                  ),
                ),
              );

              await stripe.Stripe.instance.presentPaymentSheet();

              final organiserId = GetIt.instance
                  .get<OrganiserLocalDataSource>()
                  .currentOrganiser!
                  .id!;
              await ref
                  .read(eventNotifierProvider.notifier)
                  .addEvent(organiserId, widget.eventData, widget.image);
              print(widget.eventData);
              if (ref.watch(eventNotifierProvider) is Success) {
                AutoRouter.of(context).replace(const OrganiserEventRoute());
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment Successful')),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Container(
                      padding: const EdgeInsets.all(16),
                      height: 90,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Column(
                        children: [
                          Text("Congrats!",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                          Text("Your Event is added successfully!",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                );
              }
            } catch (e) {
              print("Error presenting payment sheet: $e");
              if (e is stripe.StripeException) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text('Stripe Error: ${e.error.localizedMessage}')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            }
          },
          failure: (AppException exception) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${exception.toString()}')),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        backgroundColor: Colors.green,
      ),
      child: const Text("Go to Payment", style: TextStyle(color: Colors.white)),
    );
  }

  Widget buildParkingSelection(int index, List<ParkingModel> parkings) {
    final selection = selectedParkings[index];

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selection.selectedParking,
              hint: const Text("Select Parking"),
              isExpanded: true,
              items: parkings.map((parking) {
                return DropdownMenuItem<String>(
                  value: parking.parkingName,
                  child: Text(parking.parkingName!),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selection.selectedParking = value;
                  final selectedParking = parkings
                      .firstWhere((parking) => parking.parkingName == value);
                  selection.maxCapacity =
                      int.tryParse(selectedParking.capacity!)!;
                  selection.pricePerPlace =
                      1 + Random().nextDouble() * 9; // Set random price
                  selection.parkingId = selectedParking.id; // Set parking ID
                });
              },
            ),
            if (selection.selectedParking != null) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.euro_outlined,
                      color: Color.fromARGB(255, 40, 52, 125)),
                  const SizedBox(width: 8),
                  const Text(
                    "Price per place: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.indigo),
                  ),
                  Text(
                    "${selection.pricePerPlace.toStringAsFixed(2)} Euro",
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.directions_car,
                      color: Color.fromARGB(255, 40, 52, 125)),
                  const SizedBox(width: 8),
                  const Text(
                    "Available places: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.indigo),
                  ),
                  Text(selection.maxCapacity.toString(),
                      style: const TextStyle(fontSize: 15)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    "Place number to reserve: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.indigo),
                  ),
                  CartStepperInt(
                    value: selection.numberOfPlacesWanted,
                    size: 36,
                    didChangeCount: (value) {
                      setState(() {
                        selection.numberOfPlacesWanted =
                            (value <= selection.maxCapacity)
                                ? value
                                : selection.maxCapacity;
                      });
                    },
                    style: CartStepperTheme.of(context).copyWith(
                      activeForegroundColor: Colors.white,
                      activeBackgroundColor:
                          const Color.fromARGB(255, 149, 175, 195),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildInvoiceDetails() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.indigo, width: 2.0),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Collaboration Details',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.indigo),
          ),
          const SizedBox(height: 10),
          Text(
            'Total Price: ${totalPrice.toStringAsFixed(2)}€',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ParkingSelection {
  String? selectedParking;
  String? parkingId;
  int numberOfPlacesWanted = 1;
  int maxCapacity = 0;
  double pricePerPlace = 0.0;
}
