import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trapp_flutter/models/trip.dart';
import 'package:trapp_flutter/screens/home/recommendations/widgets/product_card.dart';


class RecPlacesWidget extends StatelessWidget {
  const RecPlacesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final trips = Provider.of<List<Trip>?>(context);

    return  Container(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: trips!.length,
                itemBuilder: (_, index) => Container(
                  padding: EdgeInsets.all(10),
                  child: ProductCard(data:trips[index]),
                ),
              ),
            );
  }
}
