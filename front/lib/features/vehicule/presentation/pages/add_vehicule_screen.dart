import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/vehicule/presentation/blocs/state/vehicule_state.dart';
import 'package:front/features/vehicule/presentation/blocs/vehicule_providers.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class AddVehiculeScreen extends ConsumerWidget {
  const AddVehiculeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController marqueController = TextEditingController();
    final TextEditingController modelController = TextEditingController();
    final TextEditingController registrationNumberController =
        TextEditingController();
    final VehiculeState = ref.watch(vehiculeNotifierProvider);
    final VehiculeNotifier = ref.read(vehiculeNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Add a Vehicule'),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
          child: Column(
            children: [
              TextFormField(
                controller: marqueController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Vehicule Brande',
                  hintText: 'Set your Vehicule Brande',
                  prefixIcon: const Icon(Icons.directions_car),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: modelController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Vehicule Model',
                  hintText: 'Set your Vehicule Model',
                  prefixIcon: const Icon(Icons.directions_car_filled_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: registrationNumberController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Vehicule Registration Number',
                  hintText: 'Set your Vehicule Registration Number',
                  prefixIcon: const Icon(Icons.confirmation_number_sharp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    if (modelController.text.isNotEmpty &&
                        marqueController.text.isNotEmpty &&
                        registrationNumberController.text.isNotEmpty) {
                      var body = {
                        "marque": marqueController.text,
                        "model": modelController.text,
                        "matricule": registrationNumberController.text
                      };
                      var iduser = GetIt.instance
                          .get<AuthLocalDataSource>()
                          .currentUser!
                          .id!;
                      VehiculeNotifier.addVehicule(iduser, body);
                    }
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
                    "Add Vehicule",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Consumer(
                builder: (context, watch, child) {
                  final state = ref.watch(vehiculeNotifierProvider);
                  if (state is Success) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
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
                            child: Column(
                              children: [
                                Text(
                                  "Congrats!",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  "Your Vehicle is added successfully!",
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
                      AutoRouter.of(context).replace(const VehiculeListRoute());
                    });
                  }
                  return SizedBox(); // or any other widget if needed
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
