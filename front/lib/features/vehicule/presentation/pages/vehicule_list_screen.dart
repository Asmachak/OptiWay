import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/vehicule/presentation/blocs/vehicule_list_provider.dart';
import 'package:front/routes/app_routes.gr.dart';

@RoutePage()
class VehiculeListScreen extends ConsumerStatefulWidget {
  const VehiculeListScreen({Key? key}) : super(key: key);

  @override
  _VehiculeListScreenState createState() => _VehiculeListScreenState();
}

class _VehiculeListScreenState extends ConsumerState<VehiculeListScreen> {
  String?
      selectedCar; // Assuming selectedCar is the groupValue for the RadioMenuButton

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vehiculeListNotifierProvider);

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
                    constraints: BoxConstraints(maxHeight: 550),
                    child: ListView.builder(
                      itemCount: vehicules.length,
                      itemBuilder: (context, index) {
                        return RadioMenuButton(
                          key: UniqueKey(), // Unique key for each widget
                          value: vehicules[index].id!,
                          groupValue: selectedCar,
                          onChanged: (selectedValue) {
                            print(selectedCar);
                            setState(
                                () => selectedCar = selectedValue.toString());
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width:
                                      70, // Adjust the width of the photo container
                                  height: 60,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          "https://cdn-icons-png.flaticon.com/512/171/171239.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${vehicules[index].marque!} ${vehicules[index].model!}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 35, 42, 83)),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      vehicules[index].matricule!,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              )
                            ],
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
