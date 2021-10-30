import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trapp_flutter/models/trip.dart';
import 'package:trapp_flutter/screens/home/recommendations/rec_places_section.dart';
import 'package:trapp_flutter/screens/home/recommendations/rec_section.dart';
import 'package:trapp_flutter/services/auth.dart';
import 'package:trapp_flutter/services/database.dart';

final AuthService _auth = AuthService();

class RecommendedTrips extends StatelessWidget {
  const RecommendedTrips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Trip>?>.value(
      initialData: null,
      value: DatabaseService().trips,
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent[50],
        body: SingleChildScrollView(
          child: Column(
            children: const <Widget>[
              SizedBox(height: 15,),
              RecommendationsWidget(),

              RecPlacesWidget(),
            ],
          ),
        ),
        extendBody: true,
        // bottomNavigationBar:
      ),
    );
  }
}
