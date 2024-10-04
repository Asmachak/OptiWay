import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/paiement/presentation/blocs/paiement_provider.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';
import 'package:front/features/vehicule/presentation/blocs/state/vehicule_list/vehicule_list_state.dart';
import 'package:front/features/vehicule/presentation/blocs/vehicule_list_provider.dart';
import 'package:front/features/vehicule/presentation/widgets/button_row.dart';
import 'package:front/features/vehicule/presentation/widgets/vehicle_card.dart';
import 'package:get_it/get_it.dart';

final selectedCarEventIdProvider = StateProvider<String?>((ref) => null);

@RoutePage()
class VehiculeListReservationEventScreen extends ConsumerStatefulWidget {
  final double finalPrice;

  const VehiculeListReservationEventScreen({Key? key, required this.finalPrice})
      : super(key: key);

  @override
  _VehiculeListReservationEventScreenState createState() =>
      _VehiculeListReservationEventScreenState();
}

class _VehiculeListReservationEventScreenState
    extends ConsumerState<VehiculeListReservationEventScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(vehiculeListNotifierProvider.notifier).getVehicules(
          GetIt.instance.get<AuthLocalDataSource>().currentUser!.id!);

      // Convert final price to an integer value in cents
      int amountInCents = (widget.finalPrice).round();

      ref
          .read(paiementNotifierProvider.notifier)
          .initPaymentSheet({"amount": amountInCents, "currency": "eur"});
    });
  }

  @override
  Widget build(BuildContext context) {
    final VehiculeListState listState = ref.watch(vehiculeListNotifierProvider);
    final selectedCarId = ref.watch(selectedCarEventIdProvider);

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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                        ref.read(selectedCarEventIdProvider.notifier).state =
                            carId;
                      },
                    ),
                    failure: (exception) => Text("$exception"),
                  ),
                ],
              ),
            ),
          ),
          const ButtonRow()
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
        final vehicule = vehicules[index];
        final isSelected = vehicule.id == selectedCarId;
        final isAvailable = vehicule.state == 'available'; // Check if the vehicle is available

        return VehiculeCard(
          vehicule: vehicule,
          isSelected: isSelected,
          isSelectable: isAvailable, // Disable card interaction if not available
          onTap: () {
            if (isAvailable) {
              onCarSelected(isSelected ? null : vehicule.id);
            }
          },
        );
      },
    );
  }
}
