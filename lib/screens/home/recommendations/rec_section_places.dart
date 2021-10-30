import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trapp_flutter/models/trip.dart';
import 'package:trapp_flutter/screens/home/recommendations/sample_data.dart';
import 'package:trapp_flutter/screens/home/recommendations/widgets/product_card.dart';
import 'package:trapp_flutter/screens/home/recommendations/widgets/titlebar.dart';

class RecsWidget extends StatelessWidget {
  const RecsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          thickness: 1,
        ),
        TitleRecomended(
          title: 'Recomended for you',
        ),
        StreamBuilder<List<Trip>>(
            stream: getData(context),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Container(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Container(
                      padding: EdgeInsets.all(10),
                      child: ProductCard(
                        data: snapshot.data![index],
                      ),
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(width: 10),
                    Text("Loading..."),
                  ],
                ),
              );
            }),
        const Divider(
          thickness: 3,
        ),
      ],
    );
  }

  Stream<List<Trip>> getData(context) async* {
    yield await Future.delayed(
      const Duration(seconds: 1),
      // () => sampleData.map((e) => ProductModel.fromData(e)).toList(),
      // Provider.of<QuerySnapshot>(context).docs.map((e) => Trip_fb({
      //
      // })).toList(),
          () => sampleData.map((e) => Trip.fromData(e)).toList(),
    );
  }
}
