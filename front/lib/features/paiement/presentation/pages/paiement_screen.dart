import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:front/features/paiement/presentation/blocs/paiement_provider.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:get_it/get_it.dart';

class PaymentPage extends ConsumerWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paiementState = ref.watch(paiementNotifierProvider);

    return Center(
      child: paiementState.when(
        initial: () => ElevatedButton(
          onPressed: () {
            ref
                .read(paiementNotifierProvider.notifier)
                .initPaymentSheet({"amount": 1000, "currency": "eur"});
          },
          child: Text('Pay with Payment Sheet'),
        ),
        loading: () => CircularProgressIndicator(),
        success: (paymentModel) => ElevatedButton(
          onPressed: () async {
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
          },
          child: Text('Complete Payment'),
        ),
        failure: (error) => Text('Error: ${error.message}'),
      ),
    );
  }
}
