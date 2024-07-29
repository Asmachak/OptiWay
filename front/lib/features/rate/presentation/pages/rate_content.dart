import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/rate/presentation/blocs/check_rate_provider.dart';
import 'package:front/features/rate/presentation/blocs/rate_provider.dart';
import 'package:front/features/rate/presentation/blocs/state/check_rate/check_state.dart'
    as check;
import 'package:front/features/rate/presentation/blocs/state/rate/rate_state.dart';
import 'package:front/features/rate/presentation/widgets/ratingBar_widget.dart';
import 'package:front/features/reservation/data/models/reservation/reservation_model.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:get_it/get_it.dart';

class RateContent extends ConsumerStatefulWidget {
  final ReservationModel reservation;
  final double eventRate;
  final double parkingRate;

  RateContent({
    Key? key,
    required this.reservation,
    required this.parkingRate,
    required this.eventRate,
  }) : super(key: key);

  @override
  _RateContentState createState() => _RateContentState();
}

class _RateContentState extends ConsumerState<RateContent> {
  final TextEditingController descriptionController = TextEditingController();
  late final StateProvider<double> parkingRatingProvider;
  late final StateProvider<double> eventRatingProvider;

  @override
  void initState() {
    super.initState();
    parkingRatingProvider = StateProvider<double>((ref) => widget.parkingRate);
    eventRatingProvider = StateProvider<double>((ref) => widget.eventRate);
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rateNotifier = ref.read(rateNotifierProvider.notifier);
    final rateState = ref.watch(rateNotifierProvider);
    final checkRateState = ref.watch(checkRateNotifierProvider);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Your review",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 67, 84, 180),
                ),
              ),
              Text(
                "Your feedback is valuable, so we can improve",
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              if (widget.reservation.ReservationParking != null) ...[
                const Text(
                  "Parking Experience",
                  style: TextStyle(
                    fontSize: 25,
                    color: Color.fromARGB(255, 32, 40, 89),
                  ),
                ),
                RatingWidget(
                  onRatingUpdate: (rating) {
                    ref.read(parkingRatingProvider.notifier).state = rating;
                  },
                  currentRating: widget.parkingRate,
                ),
              ],
              if (widget.reservation.ReservationEvent != null) ...[
                const Text(
                  "Event Experience",
                  style: TextStyle(
                    fontSize: 25,
                    color: Color.fromARGB(255, 32, 40, 89),
                  ),
                ),
                RatingWidget(
                  onRatingUpdate: (rating) {
                    ref.read(eventRatingProvider.notifier).state = rating;
                  },
                  currentRating: widget.eventRate,
                ),
              ],
              const SizedBox(height: 10.0),
              const Text(
                "Describe your experience",
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 32, 40, 89),
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "Describe your experience",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 3,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.indigo[50]),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide.none,
                        ),
                      ),
                    ),
                    child: const Text(
                      "Remind Me Later",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () async {
                      final parkingRating =
                          ref.read(parkingRatingProvider.notifier).state;
                      final eventRating =
                          widget.reservation.ReservationEvent != null
                              ? ref.read(eventRatingProvider.notifier).state
                              : null;

                      Map<String, dynamic> body = {
                        "parkingRate": parkingRating,
                        "eventRate": eventRating,
                        "description": descriptionController.text,
                      };

                      if (checkRateState is check.Failed) {
                        rateNotifier.giveRate(
                          GetIt.instance
                              .get<AuthLocalDataSource>()
                              .currentUser!
                              .id!,
                          widget.reservation.id!,
                          body,
                        );
                      } else if (checkRateState is check.Success) {
                        rateNotifier.updateRate(
                          widget.reservation.id!,
                          body,
                        );
                      }

                      if (rateState is Success) {
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
                                    "Thanks For Sharing Your Review!",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "See You Next Reservation!",
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
                        // Close the modal
                        Navigator.of(context).pop();
                      } else if (rateState is Error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              rateState.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide.none,
                        ),
                      ),
                    ),
                    child: Text(
                      "Send",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.indigo[50],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
