import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/vehicule/data/data_sources/vehicule_local_data_source.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';
import 'package:front/features/vehicule/domain/entities/vehicule_entity.dart';
import 'package:front/features/vehicule/presentation/blocs/vehicule_list_provider.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:get_it/get_it.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

@RoutePage()
class VehiculeListScreen extends ConsumerStatefulWidget {
  VehiculeListScreen({Key? key, required this.previous}) : super(key: key);

  String previous = "";

  @override
  _VehiculeListScreenState createState() => _VehiculeListScreenState();
}

class _VehiculeListScreenState extends ConsumerState<VehiculeListScreen> {
  String? selectedCar;
  late List<VehiculeModel> vehicles;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vehiculeListNotifierProvider);

    final String title;
    if (widget.previous == "reservation") {
      title = "Select a car";
    } else {
      title = 'Vehicule List';
    }
    initState() {
      super.initState();

      ref.read(vehiculeListNotifierProvider.notifier).getVehicules(
          GetIt.instance.get<AuthLocalDataSource>().currentUser!.id!);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(title),
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
              state.when(
                initial: () {
                  return const Text("initial");
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
                loaded: (vehicules) {
                  vehicles = vehicules;
                  return Container(
                    constraints: const BoxConstraints(maxHeight: 550),
                    child: ListView.builder(
                      itemCount: vehicules.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2.0,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedCar = selectedCar == vehicules[index].id
                                    ? null
                                    : vehicules[index].id;
                                print(selectedCar);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/red.jpg',
                                      width: 110,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${vehicules[index].marque} ${vehicules[index].model}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          vehicules[index].matricule ?? '',
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  if (widget.previous == "reservation") ...[
                                    RoundCheckBox(
                                      isChecked: selectedCar ==
                                          vehicules[index]
                                              .id, // Check if the car is selected
                                      onTap: (selected) {
                                        setState(() {
                                          selectedCar = selected == true
                                              ? vehicules[index].id
                                              : null; // Update selectedCar based on checkbox state
                                          print(selectedCar);
                                        });
                                      },
                                    ),
                                  ] else
                                    ...[
                                      
                                    ]
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                failure: (exception) {
                  return Text("$exception");
                },
              ),
            ],
          ),
          Center(
            child: TextButton(
              onPressed: () {
                AutoRouter.of(context)
                    .push(AddVehiculeRoute(vehicles: vehicles));
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
                "Add Vehicule",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
