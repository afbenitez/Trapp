import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trapp_flutter/models/trip.dart';
import 'package:trapp_flutter/screens/home/recommendations/rec_places_section.dart';
import 'package:trapp_flutter/screens/home/recommendations/rec_section.dart';
import 'package:trapp_flutter/services/auth.dart';
import 'package:trapp_flutter/services/database.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

final AuthService _auth = AuthService();

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  final int selected = 0;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Trip>?>.value(
      initialData: null,
      value: DatabaseService().trips,
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent[50],
        appBar: AppBar(
          title: const Text('Home Trapp'),
          backgroundColor: Colors.lightBlueAccent[300],
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(Icons.person),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const <Widget>[
              SizedBox(height: 15,),
              RecommendationsWidget(),
              RecPlacesWidget(),
              // PlacesRecomendedWidget(),
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: FloatingNavbar(
          onTap: (int val) {
            //returns tab id which is user tapped
            print(val);
          },
          currentIndex: 1,
          items: [
            FloatingNavbarItem(icon: Icons.home, title: 'Home'),
            FloatingNavbarItem(icon: Icons.explore, title: 'Explore'),
            FloatingNavbarItem(icon: Icons.chat_bubble_outline, title: 'Chats'),
            FloatingNavbarItem(icon: Icons.settings, title: 'Settings'),
          ],
        ),
      ),
    );
  }
}
