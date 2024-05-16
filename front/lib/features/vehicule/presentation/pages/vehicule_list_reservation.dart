import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/setImage.dart';
import 'package:front/features/reservation/presentation/blocs/jsonDataProvider.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';
import 'package:front/features/vehicule/presentation/blocs/state/vehicule_list/vehicule_list_state.dart';
import 'package:front/features/vehicule/presentation/blocs/vehicule_list_provider.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:get_it/get_it.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

String? _selectedCarId;

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
    ref.read(vehiculeListNotifierProvider.notifier).getVehicules(
        GetIt.instance.get<AuthLocalDataSource>().currentUser!.id!);
  }

  @override
  Widget build(BuildContext context) {
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
          _VehiculeList(
            selectedCarId: _selectedCarId,
            onCarSelected: (carId) {
              setState(() {
                _selectedCarId = carId;
              });
            },
          ),
          _ButtonRow(),
        ],
      ),
    );
  }
}

class _VehiculeList extends ConsumerWidget {
  final String? selectedCarId;
  final Function(String?) onCarSelected;

  const _VehiculeList({
    required this.selectedCarId,
    required this.onCarSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final VehiculeListState listState = ref.watch(vehiculeListNotifierProvider);

    return listState.when(
      initial: () => const Text("initial"),
      loading: () => const Center(child: CircularProgressIndicator()),
      loaded: (vehicules) => _VehiculeListView(
        vehicules: vehicules,
        selectedCarId: selectedCarId,
        onCarSelected: onCarSelected,
      ),
      failure: (exception) => Text("$exception"),
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
    return Container(
      constraints: const BoxConstraints(maxHeight: 550),
      child: ListView.builder(
        itemCount: vehicules.length,
        itemBuilder: (context, index) {
          final isSelected = vehicules[index].id == selectedCarId;
          return _VehiculeCard(
            vehicule: vehicules[index],
            isSelected: isSelected,
            onTap: () {
              print(selectedCarId);
              onCarSelected(isSelected ? null : vehicules[index].id);
            },
          );
        },
      ),
    );
  }
}

class _VehiculeCard extends StatelessWidget {
  final VehiculeModel vehicule;
  final bool isSelected;
  final VoidCallback onTap;

  const _VehiculeCard({
    required this.vehicule,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  setVehicleImage(vehicule.color.toString()),
                  width: 110,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${vehicule.marque} ${vehicule.model}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      vehicule.matricule ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              RoundCheckBox(
                isChecked: isSelected,
                onTap: (selected) {
                  onTap();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ButtonRow extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: Center(
            child: TextButton(
              onPressed: () {
                AutoRouter.of(context).push(AddVehiculeRoute(vehicles: []));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.indigo[50]),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide.none,
                  ),
                ),
              ),
              child: const Text(
                "Add Vehicle",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16), // Adjust the width as needed for spacing

        Expanded(
          child: Center(
            child: TextButton(
              onPressed: () {
                if (_selectedCarId != null) {
                  final jsonData = ref.watch(jsonDataProvider);
                  jsonData["idvehicule"] = _selectedCarId;
                  AutoRouter.of(context).push(RelatedEventRoute());
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
                "Continue",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.indigo.shade50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
