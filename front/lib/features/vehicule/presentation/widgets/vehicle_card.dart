import 'package:flutter/material.dart';
import 'package:front/core/setImage.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class VehiculeCard extends StatelessWidget {
  final VehiculeModel vehicule;
  final bool isSelected;
  final bool isSelectable; // New field to handle availability
  final VoidCallback onTap;

  const VehiculeCard({
    required this.vehicule,
    required this.isSelected,
    required this.isSelectable, // Accept the availability as a parameter
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: isSelectable ? onTap : null, // Disable tap if not selectable
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  setVehicleImage(vehicule.color.toString()),
                  width: 110,
                  height: 70,
                  fit: BoxFit.cover,
                  color: !isSelectable
                      ? Colors.grey
                      : null, // Add a grey overlay if not selectable
                  colorBlendMode: !isSelectable ? BlendMode.saturation : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${vehicule.marque} ${vehicule.model}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: isSelectable
                            ? Colors.black
                            : Colors.grey, // Grey out if not selectable
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      vehicule.matricule ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelectable
                            ? Colors.black
                            : Colors.grey, // Grey out if not selectable
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              RoundCheckBox(
                isChecked: isSelected,
                onTap: isSelectable
                    ? (selected) => onTap()
                    : null, // Disable checkbox if not selectable
                checkedColor: isSelectable
                    ? Colors.green
                    : Colors.grey, // Use grey color if not selectable
              ),
            ],
          ),
        ),
      ),
    );
  }
}
