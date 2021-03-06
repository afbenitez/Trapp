import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:trapp_flutter/models/user_fb.dart';
import 'package:trapp_flutter/screens/Trips/trips.dart';
import 'package:trapp_flutter/screens/budget/budget.dart';
import 'package:trapp_flutter/screens/connectivity/no_internet.dart';
import 'package:trapp_flutter/screens/home/home_2.dart';
import 'package:trapp_flutter/screens/item/items.dart';
import 'package:trapp_flutter/screens/profile/profile.dart';
import 'package:trapp_flutter/screens/settings/settings.dart';

import 'PlanCost/cost_plan.dart';

class Wrapper extends StatelessWidget {

  const Wrapper({Key? key}) : super(key: key);
  // LocalStorage storage = LocalStorage('trapp_storage');

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User_fb?>(context);
    // print("nana ${user?.uid}");
    return (user == null) ? const Home() : const MyStatefulWidget();
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;
  OverlayEntry? entry;
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  int _selectedIndex = 3;


  static const List<Widget> _widgetOptions =
  <Widget>[
    NoInternet(),
    costPlan(),
    Budget(),
    LoadingTrips(),
    AllItems(),
    Settings(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: NavBar(
          index: _selectedIndex,
          tap: _onItemTapped,
        ));
  }
}

class NavItem extends StatelessWidget {
  const NavItem(
      {Key? key,
        required this.index,
        required this.icon,
        required this.tap,
        required this.current})
      : super(key: key);

  final int index;
  final int current;
  final IconData icon;
  final Function tap;

  @override
  Widget build(BuildContext context) {
    return (index == current)
        ? Neumorphic(
      style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
          color: const Color(0xFF00AFB9)
      ),
      child: IconButton(
        onPressed: () {
          tap(index);
        },
        icon: Icon(
          icon,
          size: 25,
          color: Colors.white,
        ),
      ),
    )
        : IconButton(
        onPressed: () {
          tap(index);
        },
        icon: Icon(
          icon,
          size: 25,
          color: Colors.white,
        )
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({Key? key, required this.index, required this.tap})
      : super(key: key);

  final int index;
  final Function tap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      child: Neumorphic(
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
            color: const Color(0xFF00AFB9),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NavItem(
                    index: 0,
                    icon: Icons.travel_explore,
                    tap: tap,
                    current: index),
                NavItem(
                    index: 1,
                    icon: Icons.hiking_rounded,
                    tap: tap,
                    current: index),
                NavItem(
                    index: 2,
                    icon: Icons.monetization_on_rounded,
                    tap: tap,
                    current: index),
                NavItem(index: 3, icon: Icons.home, tap: tap, current: index),
                NavItem(
                    index: 4,
                    icon: Icons.card_travel,
                    tap: tap,
                    current: index),
                NavItem(
                    index: 5, icon: Icons.settings, tap: tap, current: index),
                NavItem(index: 6, icon: Icons.person, tap: tap, current: index),
              ],
            ),
          )),
    );
  }
}
