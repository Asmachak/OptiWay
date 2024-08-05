import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:front/features/paiement/presentation/blocs/paiement_provider.dart';
import 'package:front/features/reservation/presentation/blocs/jsonDataProvider.dart';
import 'package:front/features/reservation/presentation/blocs/reservationEvent_provider.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservationEvent/reservationEvent_state.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/vehicule/presentation/pages/vehicle_list_event.dart';
import 'package:front/features/vehicule/presentation/widgets/add_vehicle_button.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:get_it/get_it.dart';

class ButtonRow extends ConsumerWidget {
  const ButtonRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCarId = ref.watch(selectedCarEventIdProvider);
    final paiementState = ref.watch(paiementNotifierProvider);
    final reservationEventState = ref.watch(reservationEventNotifierProvider);

    final reservationEventNotifier =
        ref.read(reservationEventNotifierProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          const IntrinsicWidth(child: AddVehicleButton()),
          IntrinsicWidth(
            child: TextButton(
              onPressed: selectedCarId != null
                  ? () async {
                      final jsonData = ref.read(reservationEventDataProvider);
                      jsonData["idvehicule"] = selectedCarId;
                      print(" tout $jsonData");

                      paiementState.when(
                        initial: () {},
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

                            await reservationEventNotifier.addReservationEvent(
                              jsonData,
                              jsonData["iduser"],
                              jsonData["idvehicule"],
                              jsonData["idevent"],
                            );

                            if (ref.read(reservationEventNotifierProvider)
                                is Success) {
                              AutoRouter.of(context)
                                  .replace(const ReservationListRoute());
                            }
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
                  fontSize: 25,
                  color: Colors.indigo.shade50,
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
