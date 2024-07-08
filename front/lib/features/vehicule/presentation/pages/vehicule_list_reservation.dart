import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/presentation/blocs/jsonDataProvider.dart';
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
                    final jsonData = ref.read(jsonDataProvider);
                    jsonData["idvehicule"] = selectedCarId;
                    AutoRouter.of(context).push(const RelatedEventRoute());
                    print(jsonData);
                  } else {
                    print("select a car");
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
                onPressed: () {
                  if (selectedCarId != null) {
                    // Add your logic for "Go to Payment" here
                    print("Go to Payment");
                  } else {
                    print("select a car");
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
