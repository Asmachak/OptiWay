import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';
import 'package:front/features/vehicule/presentation/blocs/cars_provider.dart';
import 'package:front/features/vehicule/presentation/blocs/state/cars_brand/car_brand_notifier.dart';
import 'package:front/features/vehicule/presentation/blocs/state/cars_model/car_model_notifier.dart';
import 'package:front/features/vehicule/presentation/blocs/state/vehicule/vehicule_notifier.dart';
import 'package:front/features/vehicule/presentation/blocs/vehicule_list_provider.dart';
import 'package:front/features/vehicule/presentation/blocs/vehicule_providers.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class AddVehiculeScreen extends ConsumerStatefulWidget {
  AddVehiculeScreen({Key? key, required this.vehicles}) : super(key: key);
  final List<VehiculeModel> vehicles;

  @override
  _AddVehiculeScreenState createState() => _AddVehiculeScreenState();
}

class _AddVehiculeScreenState extends ConsumerState<AddVehiculeScreen> {
  final TextEditingController marqueController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController registrationNumberController =
      TextEditingController();

  late VehiculeNotifier vehiculeNotifier;
  late CarsBrandNotifier carBrandNotifier;
  late CarsModelNotifier carModelNotifier;

  late String selectedCar;
  late String selectedCarModel;
  late String selectedColor;

  List<dynamic> filteredCarModels = [];

  List<Color> colors = [
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.white,
    Colors.yellow,
    Colors.green,
    Colors.grey,
  ];

  bool isMatriculeExists(String matricule) {
    return widget.vehicles.any((vehicle) => vehicle.matricule == matricule);
  }

  @override
  void initState() {
    super.initState();
    initializeNotifiers();
  }

  void initializeNotifiers() {
    vehiculeNotifier = ref.read(vehiculeNotifierProvider.notifier);
    carModelNotifier = ref.read(carsModelNotifierProvider.notifier);

    selectedCar = "";
    selectedCarModel = "";
    selectedColor = "";
  }

  @override
  void _showModalBottomSheet(BuildContext context, String state) {
    final stateBrand = ref.watch(carsBrandNotifierProvider);
    final stateModel = ref.watch(carsModelNotifierProvider);
    String searchQuery = "";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state == "model")
                const Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 10, 10, 0),
                  child: Text(
                    "Select a Car Model",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Color.fromARGB(255, 51, 64, 133),
                    ),
                  ),
                )
              else
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Select a Car Brand",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Color.fromARGB(255, 51, 64, 133),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  style: const TextStyle(
                    color: Color.fromARGB(255, 51, 64, 133),
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                        const Color.fromARGB(255, 82, 99, 176).withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: state == 'brand'
                        ? "Find Your Car Manufacturer"
                        : "Find Your Car Model",
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: const Color.fromARGB(255, 45, 56, 116),
                  ),
                  onChanged: (query) {
                    setState(() {
                      searchQuery = query;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (state == "brand") ...[
                SizedBox(
                  height: 600,
                  child: stateBrand.when(
                    initial: () {
                      return const Text("initial");
                    },
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                    loaded: (cars) {
                      final carsToShow = searchQuery.isEmpty
                          ? cars
                          : cars
                              .where((car) => car
                                  .toLowerCase()
                                  .contains(searchQuery.toLowerCase()))
                              .toList();
                      return ListView.builder(
                        itemCount: carsToShow.length,
                        itemBuilder: (BuildContext context, int index) {
                          final car = carsToShow[index];
                          return ListTile(
                            title: Text(car),
                            onTap: () {
                              setState(() {
                                selectedCar = car;
                              });
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    },
                    failure: (exception) {
                      return Text("$exception");
                    },
                  ),
                ),
              ] else ...[
                SizedBox(
                  height: 600,
                  child: stateModel.when(
                    initial: () {
                      return const Text("initial");
                    },
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                    loaded: (cars) {
                      final carsToShow = searchQuery.isEmpty
                          ? cars
                          : cars
                              .where((car) => car
                                  .toLowerCase()
                                  .contains(searchQuery.toLowerCase()))
                              .toList();
                      return ListView.builder(
                        itemCount: carsToShow.length,
                        itemBuilder: (BuildContext context, int index) {
                          final car = carsToShow[index];
                          return ListTile(
                            title: Text(car),
                            onTap: () {
                              setState(() {
                                selectedCarModel = car;
                              });
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    },
                    failure: (exception) {
                      return Text("$exception");
                    },
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    final vehicleState = ref.watch(vehiculeNotifierProvider);
    final vehiculeListNotifier =
        ref.read(vehiculeListNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Add a Vehicle'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Your Car Brand',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 117, 117, 117),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () async {
                  carBrandNotifier =
                      await ref.read(carsBrandNotifierProvider.notifier);

                  await carBrandNotifier.getManufacturer();
                  _showModalBottomSheet(context, "brand");
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.indigo[100]!;
                      } else {
                        return Colors.transparent;
                      }
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      selectedCar.isNotEmpty
                          ? selectedCar
                          : "Find your Car Brand ",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 52, 66, 143),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Choose Your Car Model',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 117, 117, 117),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () async {
                  if (selectedCar != '') {
                    await carModelNotifier.getModels(selectedCar);
                    _showModalBottomSheet(context, "model");
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('woooy'),
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.indigo[100]!;
                      } else {
                        return Colors.transparent;
                      }
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      selectedCarModel.isNotEmpty
                          ? selectedCarModel
                          : "Find your Car Model ",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 52, 66, 143),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Tap Your Car registration Number',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 117, 117, 117),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 55,
                child: TextField(
                  controller: registrationNumberController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Enter Your Car registration Number',
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Tap Your Car color',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 117, 117, 117),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: colors.length,
                  itemBuilder: (BuildContext context, int index) {
                    final myColor = colors[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = myColor.toString();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: myColor == Colors.white
                                  ? Colors.black
                                  : Colors.transparent,
                            ),
                            color: myColor,
                          ),
                          child: selectedColor == myColor.toString() &&
                                  myColor != Colors.white
                              ? const Icon(Icons.check, color: Colors.white)
                              : selectedColor == myColor.toString() &&
                                      myColor == Colors.white
                                  ? const Icon(Icons.check, color: Colors.black)
                                  : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      if (selectedCar.isNotEmpty &&
                          selectedCarModel.isNotEmpty &&
                          selectedColor.isNotEmpty &&
                          registrationNumberController.text.isNotEmpty) {
                        var body = {
                          "marque": selectedCar,
                          "model": selectedCarModel,
                          "matricule": registrationNumberController.text,
                          "color": selectedColor,
                        };
                        if (isMatriculeExists(
                            registrationNumberController.text)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Container(
                                padding: const EdgeInsets.all(16),
                                height: 90,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 175, 76, 76),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: const Column(
                                  children: [
                                    Text(
                                      "Oops!",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "This Car Number is already added!",
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
                        } else {
                          var iduser = GetIt.instance
                              .get<AuthLocalDataSource>()
                              .currentUser!
                              .id!;
                          vehiculeNotifier.addVehicule(iduser, body);
                        }
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
                      "Add Vehicle",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // SnackBar for feedback

              Consumer(
                builder: (context, watch, child) {
                  final vehicleState = ref.watch(vehiculeNotifierProvider);

                  vehiculeListNotifier.getVehicules(GetIt.instance
                      .get<AuthLocalDataSource>()
                      .currentUser!
                      .id!);
                  return vehicleState.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    success: (car) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
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
                              child: const Column(
                                children: [
                                  Text(
                                    "Congrats!",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Your Car is added successfully!",
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

                        AutoRouter.of(context).popForced();

                        // Reset the state after navigation
                        vehiculeNotifier.resetState();
                        carBrandNotifier.resetState();
                        carModelNotifier.resetState();
                      });
                      return const SizedBox.shrink();
                    },
                    failure: (exception) => Text("$exception"),
                    deleted: () => const Text("success"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
