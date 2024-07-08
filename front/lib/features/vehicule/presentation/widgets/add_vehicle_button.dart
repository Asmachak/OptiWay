import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/routes/app_routes.gr.dart';

class AddVehicleButton extends StatelessWidget {
  const AddVehicleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: SizedBox(
        width: double.infinity, // Ensures the button takes the full width
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
    );
  }
}
