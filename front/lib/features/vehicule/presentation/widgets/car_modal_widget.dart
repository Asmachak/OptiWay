import 'package:flutter/material.dart';

class CarModelModalSheet extends StatefulWidget {
  @override
  _CarModelModalSheetState createState() => _CarModelModalSheetState();
}

class _CarModelModalSheetState extends State<CarModelModalSheet> {
  List<String> carModels = [
    'Toyota Camry',
    'Honda Civic',
    'Ford Mustang',
    'Chevrolet Corvette',
    'BMW X5',
    // Add more car models as needed
  ];

  List<String> filteredCarModels = [];

  @override
  void initState() {
    super.initState();
    filteredCarModels.addAll(carModels);
  }

  void filterCarModels(String query) {
    setState(() {
      filteredCarModels = carModels
          .where((model) => model.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void showCarModelModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) => SingleChildScrollView(
        child: Container(
            // padding: EdgeInsets.all(16.0),
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     TextField(
            //       decoration: InputDecoration(
            //         hintText: 'Search car models',
            //       ),
            //       onChanged: (query) => filterCarModels(query),
            //     ),
            //     SizedBox(height: 16.0),
            //     Expanded(
            //       child: ListView.builder(
            //         itemCount: filteredCarModels.length,
            //         itemBuilder: (context, index) {
            //           final carModel = filteredCarModels[index];
            //           return ListTile(
            //             title: Text(carModel),
            //             onTap: () {
            //               // Handle selection of car model
            //               Navigator.pop(context, carModel);
            //             },
            //           );
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => showCarModelModalSheet(context),
        child: Text('Show Car Models'),
      ),
    );
  }
}
