import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/paiement/presentation/widgets/transaction_card.dart';
import 'package:front/features/reservation/presentation/blocs/reservation_providers.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class BillingHistoricScreen extends ConsumerStatefulWidget {
  const BillingHistoricScreen({super.key});

  @override
  ConsumerState<BillingHistoricScreen> createState() =>
      _BillingHistoricScreenState();
}

class _BillingHistoricScreenState extends ConsumerState<BillingHistoricScreen> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(reservationNotifierProvider.notifier).getReservation(
          GetIt.instance.get<AuthLocalDataSource>().currentUser!.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final reservationState = ref.watch(reservationNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text("Billing History"),
      ),
      body: Column(
        children: [
          reservationState.when(
            initial: () => const SizedBox(),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (reservations) {
              return Expanded(
                child: ListView.builder(
                  itemCount: reservations.length,
                  itemBuilder: (BuildContext context, int index) {
                    final reservation = reservations[index];
                    return TransactionCard(
                      reservation: reservation,
                    );
                  },
                ),
              );
            },
            failure: (exception) => Center(child: Text(exception.toString())),
            success: (reservation) => const SizedBox(),
            extended: (reservation) => const SizedBox(),
          ),
        ],
      ),
    );
  }
}
