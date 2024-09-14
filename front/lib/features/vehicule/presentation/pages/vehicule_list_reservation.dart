import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:front/features/paiement/presentation/blocs/paiement_provider.dart';
import 'package:front/features/reservation/presentation/blocs/jsonDataProvider.dart';
import 'package:front/features/reservation/presentation/blocs/reservationParking_provider.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';
import 'package:front/features/vehicule/presentation/blocs/state/vehicule_list/vehicule_list_state.dart';
import 'package:front/features/vehicule/presentation/blocs/vehicule_list_provider.dart';
import 'package:front/features/vehicule/presentation/widgets/add_vehicle_button.dart';
import 'package:front/features/vehicule/presentation/widgets/vehicle_card.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:get_it/get_it.dart';

final selectedCarIdProvider = StateProvider<String?>((ref) => null);

@RoutePage()
class VehiculeListReservationScreen extends ConsumerStatefulWidget {
  VehiculeListReservationScreen({Key? key}) : super(key: key);

  @override
  _VehiculeListReservationScreenState createState() =>
      _VehiculeListReservationScreenState();
}

class _VehiculeListReservationScreenState
    extends ConsumerState<VehiculeListReservationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(vehiculeListNotifierProvider.notifier).getVehicules(
          GetIt.instance.get<AuthLocalDataSource>().currentUser!.id!);

      var jsonData = ref.read(reservationParkingDataProvider);

      ref
          .read(paiementNotifierProvider.notifier)
          .initPaymentSheet({"amount": jsonData["tarif"], "currency": "eur"});
    });
  }

  @override
  Widget build(BuildContext context) {
    final VehiculeListState listState = ref.watch(vehiculeListNotifierProvider);
    final selectedCarId = ref.watch(selectedCarIdProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text("Select a car"),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                listState.when(
                  initial: () => const Text("initial"),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (vehicules) => _VehiculeListView(
                    vehicules: vehicules,
                    selectedCarId: selectedCarId,
                    onCarSelected: (carId) {
                      ref.read(selectedCarIdProvider.notifier).state = carId;
                    },
                  ),
                  failure: (exception) => Text("$exception"),
                ),
                const SizedBox(height: 150), // Placeholder for sticky elements
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AddVehicleButton(),
                _ButtonRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VehiculeListView extends StatelessWidget {
  final List<VehiculeModel> vehicules;
  final String? selectedCarId;
  final Function(String?) onCarSelected;

  const _VehiculeListView({
    required this.vehicules,
    required this.selectedCarId,
    required this.onCarSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: vehicules.length,
      itemBuilder: (context, index) {
        final isSelected = vehicules[index].id == selectedCarId;
        return VehiculeCard(
          vehicule: vehicules[index],
          isSelected: isSelected,
          onTap: () {
            onCarSelected(isSelected ? null : vehicules[index].id);
          },
        );
      },
    );
  }
}

class _ButtonRow extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCarId = ref.watch(selectedCarIdProvider);
    final paiementState = ref.watch(paiementNotifierProvider);
    final reservationParkingNotifier =
        ref.read(reservationParkingNotifierProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Center(
              child: TextButton(
                onPressed: () {
                  if (selectedCarId != null) {
                    final jsonData = ref.read(reservationParkingDataProvider);
                    final json = ref.read(reservationEventDataProvider);
                    json["idvehicule"] = selectedCarId;
                    jsonData["idvehicule"] = selectedCarId;
                    AutoRouter.of(context).push(const RelatedEventRoute());
                    print("salem $json");
                  } else {
                    print("Select a car");
                  }
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
                  "See Related Events",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.indigo.shade50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Center(
              child: TextButton(
                onPressed: selectedCarId != null
                    ? () async {
                        print("Go to Payment");
                        final jsonData =
                            ref.read((reservationParkingDataProvider));
                        jsonData["idvehicule"] =
                            selectedCarId; // Update jsonData with selected car ID

                        paiementState.when(
                          initial: () {
                            const SizedBox();
                          },
                          loading: () => const CircularProgressIndicator(),
                          success: (paymentModel) async {
                            Stripe.publishableKey = paymentModel.publishableKey;
                            BillingDetails billingDetails = BillingDetails(
                              address: Address(
                                country: 'BE',
                                city: GetIt.instance
                                    .get<AuthLocalDataSource>()
                                    .currentUser!
                                    .city!,
                                line1: 'addr1',
                                line2: 'addr2',
                                postalCode: '1000',
                                state: 'bruxelle',
                              ),
                            );

                            try {
                              await Stripe.instance.initPaymentSheet(
                                paymentSheetParameters:
                                    SetupPaymentSheetParameters(
                                  customFlow: false,
                                  merchantDisplayName: 'MOBIZATE',
                                  paymentIntentClientSecret:
                                      paymentModel.paymentIntent,
                                  customerEphemeralKeySecret:
                                      paymentModel.ephemeralKey,
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
                                const SnackBar(
                                    content: Text('Payment Successful')),
                              );

                              print("Updated jsonData: $jsonData");

                              await reservationParkingNotifier
                                  .addReservationParking(
                                      jsonData,
                                      jsonData["idparking"],
                                      jsonData["iduser"],
                                      jsonData["idvehicule"]);

                              AutoRouter.of(context)
                                  .replace(const ReservationListRoute());
                            } catch (e) {
                              print("Error presenting payment sheet: $e");
                              if (e is StripeException) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Error: ${e.error.localizedMessage}')),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $e')),
                                );
                              }
                            }
                          },
                          failure: (error) => Text('Error: ${error.message}'),
                        );
                      }
                    : null,
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
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
