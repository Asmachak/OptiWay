import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/setImage.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservation_state.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';
import 'package:front/features/vehicule/presentation/blocs/state/vehicule/vehicule_state.dart';
import 'package:front/features/vehicule/presentation/blocs/vehicule_list_provider.dart';
import 'package:front/features/vehicule/presentation/blocs/vehicule_providers.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class VehiculeListScreen extends ConsumerStatefulWidget {
  const VehiculeListScreen({Key? key}) : super(key: key);

  @override
  _VehiculeListScreenState createState() => _VehiculeListScreenState();
}

class _VehiculeListScreenState extends ConsumerState<VehiculeListScreen> {
  String? selectedCar;
  late List<VehiculeModel> vehicles;
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vehiculeListNotifierProvider);
    _refreshCarList() {
      ref.read(vehiculeListNotifierProvider.notifier).getVehicules(
          GetIt.instance.get<AuthLocalDataSource>().currentUser!.id!);
    }

    if (state is! Loaded) {
      _refreshCarList();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Vehicule List'),
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
                                      setVehicleImage(
                                          vehicules[index].color.toString()),
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
                                  GestureDetector(
                                    onTap: () async {
                                      await ref
                                          .read(
                                              vehiculeNotifierProvider.notifier)
                                          .deleteVehicule(
                                              vehicules[index].id.toString());
                                      var stateVehicule =
                                          ref.watch(vehiculeNotifierProvider);
                                      print(stateVehicule);
                                      print("state veh $stateVehicule");
                                      if (stateVehicule is Deleted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Container(
                                              padding: const EdgeInsets.all(16),
                                              height: 90,
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 175, 76, 76),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                              ),
                                              child: const Column(
                                                children: [
                                                  Text(
                                                    " The Car is deleted Successfully! ",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                          ),
                                        );
                                        ref
                                            .read(vehiculeListNotifierProvider
                                                .notifier)
                                            .getVehicules(GetIt.instance
                                                .get<AuthLocalDataSource>()
                                                .currentUser!
                                                .id!);
                                      }
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      size: 35,
                                      color: Color.fromARGB(255, 214, 52, 41),
                                    ),
                                  )
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
          Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      AutoRouter.of(context)
                          .push(AddVehiculeRoute(vehicles: vehicles));
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
              const SizedBox(
                  width: 16), // Adjust the width as needed for spacing
            ],
          )
        ],
      ),
    );
  }
}
