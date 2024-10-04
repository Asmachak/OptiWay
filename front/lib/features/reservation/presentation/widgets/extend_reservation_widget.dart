import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/paiement/presentation/blocs/paiement_provider.dart';
import 'package:front/features/reservation/data/models/reservation/reservation_model.dart';
import 'package:front/features/reservation/presentation/blocs/reservation_providers.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservation/reservation_state.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class ExtendReservationContent extends ConsumerStatefulWidget {
  final ReservationModel reservation;

  ExtendReservationContent({Key? key, required this.reservation})
      : super(key: key);

  @override
  ConsumerState<ExtendReservationContent> createState() =>
      _ExtendReservationContentState();
}

class _ExtendReservationContentState
    extends ConsumerState<ExtendReservationContent> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    // Parse the reservation.endedAt to initialize the date and time
    if (widget.reservation.EndedAt != null) {
      final endTime = DateTime.parse(widget.reservation.EndedAt!);
      selectedDate = endTime;
      selectedTime = TimeOfDay(hour: endTime.hour + 1, minute: endTime.minute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final reservationState = ref.watch(reservationNotifierProvider);

    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Center(
                child: Text(
                  "Pick the duration to add",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 51, 59, 103),
                  ),
                ),
              ),
            ),
            const Text(
              "End time",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 110, 110, 110),
              ),
            ),
            const SizedBox(height: 10),
            ConstrainedBox(
              constraints:
                  const BoxConstraints.tightFor(height: 52, width: 350),
              child: TextButton(
                onPressed: () {
                  _selectDateTime(context);
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 130, 130, 130),
                    ),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 25),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Color.fromARGB(255, 107, 106, 106),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        selectedDate != null && selectedTime != null
                            ? '${selectedDate!.toLocal().toString().split(' ')[0]} ${selectedTime!.format(context)}'
                            : 'Select Date & Time',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            ConstrainedBox(
              constraints:
                  const BoxConstraints.tightFor(height: 52, width: 350),
              child: ElevatedButton(
                onPressed: () async {
                  if (selectedDate != null && selectedTime != null) {
                    final DateTime newEndTime = DateTime(
                      selectedDate!.year,
                      selectedDate!.month,
                      selectedDate!.day,
                      selectedTime!.hour,
                      selectedTime!.minute,
                    );
                    final String formattedEndTime =
                        DateFormat('yyyy-MM-ddTHH:mm:ss').format(newEndTime);

                    var body = {
                      "EndedAt": formattedEndTime,
                    };

                    try {
                      // Update reservation state
                      // await ref
                      //     .read(reservationNotifierProvider.notifier)
                      //     .extendReservation(widget.reservation.id!, body);
                      _extendReservation();
                      // Check the new state
                      final updatedReservationState =
                          ref.read(reservationNotifierProvider);

                      if (updatedReservationState is Extended) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Container(
                              padding: const EdgeInsets.all(16),
                              height: 90,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    "Congrats!",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  Text(
                                    " Your reservation is extended successfully!",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                        );
                        Navigator.pop(context);
                        Navigator.pop(context);

                        // Reload reservation information after extension
                        ref
                            .read(reservationNotifierProvider.notifier)
                            .getReservation(
                              GetIt.instance
                                  .get<AuthLocalDataSource>()
                                  .currentUser!
                                  .id!,
                            );
                      } else if (updatedReservationState is Failure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Container(
                              padding: const EdgeInsets.all(16),
                              height: 90,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 175, 76, 76),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    "Oops!",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  Text(
                                    "Something Went Wrong!",
                                    style: TextStyle(color: Colors.white),
                                  ),
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
                      // Handle errors
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Container(
                            padding: const EdgeInsets.all(16),
                            height: 90,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 175, 76, 76),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: const Column(
                              children: [
                                Text(
                                  "Oops!",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  "An error occurred!",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                      );
                    }
                  } else {
                    print('Please select both date and time.');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Extend Parking Time',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2026),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime ?? TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDate = pickedDate;
          selectedTime = pickedTime;
        });
      }
    }
  }

  Future<void> _extendReservation() async {
    if (selectedDate == null || selectedTime == null) {
      // Alert user if date/time isn't selected
      print('Please select both date and time.');
      return;
    }

    // Combine the selected date and time into one DateTime object
    final DateTime newEndTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    // Parse the current reservation's EndedAt to calculate added hours
    final DateTime currentEndTime = DateTime.parse(widget.reservation.EndedAt!);

    // Calculate the difference in hours between the new and current end times
    final Duration durationDifference = newEndTime.difference(currentEndTime);
    final double addedHours = durationDifference.inMinutes / 60.0;

    // Calculate the total price (added hours * 0.5)
    final double totalPrice = addedHours * 0.5;
    int totalPriceInCents = (totalPrice).round(); // Convert to cents for Stripe

    // Format the new end time as a string for updating the reservation
    final String formattedEndTime =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(newEndTime);

    try {
      // Step 1: Initiate payment sheet
      await ref.watch(paiementNotifierProvider.notifier).initPaymentSheet(
        {"amount": totalPriceInCents, "currency": "eur"},
      );

      final paiementState = ref.read(paiementNotifierProvider);

      paiementState.when(
        initial: () {},
        loading: () => const CircularProgressIndicator(),
        success: (paymentModel) async {
          try {
            // Setup Stripe Payment
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
                state: 'Bruxelles',
              ),
            );

            // Initialize Payment Sheet
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

            // Step 2: Present Payment Sheet
            await Stripe.instance.presentPaymentSheet();

            // Step 3: Extend Reservation only if payment succeeds
            await _updateReservation(formattedEndTime);
          } catch (e) {
            _handleStripeError(e);
          }
        },
        failure: (AppException exception) {
          _showSnackBar(context, 'Payment Error', 'Failed to process payment!');
        },
      );
    } catch (e) {
      print("Error during payment process: $e");
      _showSnackBar(
          context, 'Error', 'An error occurred while processing payment.');
    }
  }

  void _showSnackBar(BuildContext context, String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(16),
          height: 90,
          decoration: BoxDecoration(
            color: title == "Congrats!"
                ? Colors.green
                : const Color.fromARGB(255, 175, 76, 76),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 18, color: Colors.white)),
              Text(message, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  void _handleStripeError(dynamic e) {
    if (e is StripeException) {
      _showSnackBar(context, 'Stripe Error',
          e.error.localizedMessage ?? 'Payment failed.');
    } else {
      _showSnackBar(context, 'Error', 'An error occurred during payment.');
    }
  }

  Future<void> _updateReservation(String formattedEndTime) async {
    var body = {
      "EndedAt": formattedEndTime,
    };

    try {
      // Update the reservation with the new end time
      await ref
          .read(reservationNotifierProvider.notifier)
          .extendReservation(widget.reservation.id!, body);

      final updatedReservationState = ref.read(reservationNotifierProvider);

      if (updatedReservationState is Extended) {
        _showSnackBar(
            context, "Congrats!", "Your reservation is extended successfully!");
        AutoRouter.of(context).replace(ReservationListRoute());

        // Refresh reservations after extending
        ref.read(reservationNotifierProvider.notifier).getReservation(
              GetIt.instance.get<AuthLocalDataSource>().currentUser!.id!,
            );

        // Navigate back after success
        Navigator.pop(context);
      } else if (updatedReservationState is Failure) {
        _showSnackBar(context, "Oops!", "Failed to extend the reservation.");
      }
    } catch (e) {
      _showSnackBar(context, "Error",
          "An error occurred while updating the reservation.");
    }
  }
}
