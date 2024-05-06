import 'package:flutter/material.dart';

class VehiculeWidget extends StatefulWidget {
  const VehiculeWidget({
    Key? key,
    required this.marque,
    required this.matricule,
    required this.model,
  }) : super(key: key);

  final String marque;
  final String matricule;
  final String model;

  @override
  _VehiculeWidgetState createState() => _VehiculeWidgetState();
}

class _VehiculeWidgetState extends State<VehiculeWidget> {
  bool _isSelected = true; // Initialize the radio button to be selected

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            // width: double.maxFinite,
            // height: 140,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 149, 160, 214).withOpacity(0.1),
            ),
            child: Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: _isSelected,
                  onChanged: (value) {
                    setState(() {
                      _isSelected = value!;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 110, // Adjust the width of the photo container
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
                const SizedBox(
                    width: 8), // Add some spacing between the photo and text
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.marque} ${widget.model}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 35, 42, 83)),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2, // Set maximum lines for the text
                        ),
                        const SizedBox(height: 4), // Add some vertical spacing
                        Text(
                          widget.matricule,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
