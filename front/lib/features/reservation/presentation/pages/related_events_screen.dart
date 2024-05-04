import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/presentation/blocs/reservation_providers.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservation_state.dart';

@RoutePage()
class RelatedEventScreen extends ConsumerWidget {
  const RelatedEventScreen({Key? key, required this.json});
  final json;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservationState = ref.watch(reservationNotifierProvider);
    final reservationNotifier = ref.read(reservationNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text("Related Events"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
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
                    "Continu",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    // Action for the "Skip" button
                    reservationNotifier.addReservation(json);
                    if (reservationState is Success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Container(
                            padding: const EdgeInsets.all(16),
                            height: 90,
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: const Column(
                              children: [
                                Text(
                                  "Congrats!",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                    " Your reservation have been added successfully!",
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
                  },
                  icon: const Icon(Icons.arrow_right_outlined,
                      color: Colors.blueGrey),
                  label: const Text(
                    "Skip",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
