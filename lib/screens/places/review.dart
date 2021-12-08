import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:trapp_flutter/models/place.dart';

class Review extends StatelessWidget {
  final Place place;
  const Review({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        child: ListView.builder(
          itemCount: place.reviews.length,
          itemBuilder: (BuildContext context, int index) {
            return RatingBar.builder(
              initialRating: (Random().nextInt(40)/10+1),
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                // print(rating);
              },
            );
          },
        ),
      ),
    );
  }
}
