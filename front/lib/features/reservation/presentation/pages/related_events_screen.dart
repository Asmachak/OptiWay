import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/loading.dart';
import 'package:front/features/reservation/presentation/blocs/jsonDataProvider.dart';
import 'package:front/features/reservation/presentation/blocs/reservation_providers.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class RelatedEventScreen extends ConsumerWidget {
  const RelatedEventScreen({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservationState = ref.watch(reservationNotifierProvider);
    final reservationNotifier = ref.read(reservationNotifierProvider.notifier);
    final json = ref.watch(jsonDataProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text("Related Events"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
          const Text(
            "No Events Related to this parking!!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.indigo,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16), // Add space between text and animation
          Center(
            child: Lottie.asset("assets/animations/events.json"),
          ),
          const SizedBox(height: 16), // Add space below the animation
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    print("json $json");
                    await reservationNotifier.addReservation(json);
                    print("terminated");
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.indigo[50]),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide.none,
                      ),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                const SizedBox(width: 16), // Add space between buttons
                reservationState.when(initial: () {
                  return const SizedBox();
                }, loading: () {
                  return Container(
                    child: loadingWidget(),
                  );
                }, failure: (failure) {
                  return Text(failure.toString());
                }, success: (reservation) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
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
                              Text(
                                "Congrats!",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              Text(
                                " Your Car is added successfully!",
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
                  });
                  return const SizedBox.shrink();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
