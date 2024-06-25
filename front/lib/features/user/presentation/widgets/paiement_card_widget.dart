import 'package:flutter/material.dart';

class PaiementCardWidget extends StatelessWidget {
  const PaiementCardWidget({
    Key? key,
    required this.title,
    required this.imagePath, // Add imagePath field for the image
    required this.onPress,
    this.textColor,
  }) : super(key: key);

  final String title;
  final String imagePath; // Define imagePath for the image
  final VoidCallback onPress;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onPress, // Use the provided onPress callback here
        leading: Container(
          width: 60, // Increase the width for a bigger image
          height: 60, // Increase the height for a bigger image
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.indigo.withOpacity(0.1),
          ),
          child: Image.asset(imagePath), // Use Image.asset with the imagePath
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ));
  }
}
