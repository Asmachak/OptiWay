import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarWidget extends StatelessWidget {
  final double rate;

  const RatingBarWidget({Key? key, required this.rate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: RatingBar.builder(
        initialRating: rate,
        minRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemSize: 30,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          // Handle rating updates if needed
        },
      ),
    );
  }
}
