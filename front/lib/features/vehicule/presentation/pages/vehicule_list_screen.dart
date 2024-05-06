import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/vehicule/presentation/blocs/vehicule_list_provider.dart';
import 'package:front/features/vehicule/presentation/widgets/vehicule_widget.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class VehiculeListScreen extends ConsumerWidget {
  const VehiculeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(vehiculeListNotifierProvider);
    // ref.read(vehiculeListNotifierProvider.notifier).getVehicules(
    //     GetIt.instance.get<AuthLocalDataSource>().currentUser!.id!);

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
                    return Container(
                      constraints: const BoxConstraints(
                          maxHeight: 500), // Limit height as needed
                      child: ListView.builder(
                        itemCount: vehicules.length,
                        itemBuilder: (context, index) {
                          // Build your UI for each vehicule here
                          return VehiculeWidget(
                            marque: vehicules[index].marque!,
                            matricule: vehicules[index].matricule!,
                            model: vehicules[index].model!,
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
                  AutoRouter.of(context).push(const AddVehiculeRoute());
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
                    fontSize: 20,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
