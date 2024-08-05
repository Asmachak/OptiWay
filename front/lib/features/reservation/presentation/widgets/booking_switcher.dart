import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/loading.dart';
import 'package:front/features/reservation/presentation/blocs/reservation_providers.dart';
import 'package:front/features/reservation/presentation/widgets/booking_card.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';

final bookingSwitcherProvider =
    StateNotifierProvider<BookingSwitcherNotifier, bool>((ref) {
  return BookingSwitcherNotifier();
});

class BookingSwitcherNotifier extends StateNotifier<bool> {
  BookingSwitcherNotifier() : super(true);

  void selectOnGoing() {
    state = true;
  }

  void selectHistory() {
    state = false;
  }
}

class BookingSwitcher extends ConsumerStatefulWidget {
  const BookingSwitcher({super.key});

  @override
  _BookingSwitcherState createState() => _BookingSwitcherState();
}

class _BookingSwitcherState extends ConsumerState<BookingSwitcher> {
  bool isOnGoingSelected = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(reservationNotifierProvider.notifier).getReservation(
          GetIt.instance.get<AuthLocalDataSource>().currentUser!.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final reservationNotifier = ref.read(reservationNotifierProvider.notifier);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isOnGoingSelected = true;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isOnGoingSelected
                            ? Colors.indigo
                            : Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "On Going Booking",
                      style: TextStyle(
                        color: isOnGoingSelected ? Colors.indigo : Colors.grey,
                        fontWeight: isOnGoingSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: isOnGoingSelected ? 18 : 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isOnGoingSelected = false;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: !isOnGoingSelected
                            ? Colors.indigo
                            : Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Booking History",
                      style: TextStyle(
                        color: !isOnGoingSelected ? Colors.indigo : Colors.grey,
                        fontWeight: !isOnGoingSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: !isOnGoingSelected ? 18 : 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: isOnGoingSelected
              ? const OnGoingContainer()
              : const HistoryContainer(),
        ),
      ],
    );
  }
}

class OnGoingContainer extends ConsumerWidget {
  const OnGoingContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservationState = ref.watch(reservationNotifierProvider);

    return reservationState.when(
      initial: () => const SizedBox.shrink(),
      loading: () => loadingWidget(),
      loaded: (reservations) {
        final onGoingReservations = reservations
            .where((reservation) => reservation.state != "ended")
            .toList();

        if (onGoingReservations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/animations/car.json",
                ),
                const Text("No On Going Reservations ")
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: onGoingReservations.length,
          itemBuilder: (context, index) {
            final reservation = onGoingReservations[index];
            return BookingCardWidget(reservation: reservation);
          },
        );
      },
      success: (car) => const SizedBox.shrink(),
      failure: (exception) => Center(child: Text("$exception")),
      extended: (reservation) => const SizedBox.shrink(),
    );
  }
}

class HistoryContainer extends ConsumerWidget {
  const HistoryContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservationState = ref.watch(reservationNotifierProvider);

    return reservationState.when(
      initial: () => const SizedBox.shrink(),
      loading: () => loadingWidget(),
      loaded: (reservations) {
        final historyReservations = reservations
            .where((reservation) => reservation.state == "ended")
            .toList();

        if (historyReservations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/animations/car.json"),
                const Text("No Reservations Yet")
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: historyReservations.length,
          itemBuilder: (context, index) {
            final reservation = historyReservations[index];
            return BookingCardWidget(reservation: reservation);
          },
        );
      },
      success: (car) => const SizedBox.shrink(),
      failure: (exception) => Center(child: Text("$exception")),
      extended: (reservation) => const SizedBox.shrink(),
    );
  }
}
