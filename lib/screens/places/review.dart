import 'package:flutter/material.dart';
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
            return Container(
              child: Text(
                '${place.reviews[index]['calification']}'
              ),
            );
          },
        ),
      ),
    );
  }
}
