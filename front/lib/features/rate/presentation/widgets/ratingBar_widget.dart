import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingWidget extends StatefulWidget {
  final Function(double) onRatingUpdate;
  final double currentRating;
  const RatingWidget(
      {Key? key, required this.onRatingUpdate, required this.currentRating})
      : super(key: key);

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  late double _currentRating;
  @override
  void initState() {
    super.initState();
    _currentRating = widget.currentRating;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RatingBar.builder(
        initialRating: _currentRating,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 2),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          setState(() {
            _currentRating = rating;
          });
          widget.onRatingUpdate(rating);
        },
      ),
    );
  }
}
