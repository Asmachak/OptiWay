import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/routes/app_routes.gr.dart';

@RoutePage()
class VehiculeListScreen extends StatelessWidget {
  const VehiculeListScreen({super.key});

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
            child: Text('Vehicule List'),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: TextButton(
                  onPressed: () {
                    AutoRouter.of(context).push(const AddVehiculeRoute());
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
            ],
          ),
        ));
  }
}
