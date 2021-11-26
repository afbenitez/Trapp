import 'dart:io';

import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:trapp_flutter/models/place.dart';
import 'package:trapp_flutter/models/trip.dart';

import 'package:trapp_flutter/screens/Trips/no_trips_internet.dart';

import 'package:trapp_flutter/screens/Trips/tripDetail.dart';
import 'package:trapp_flutter/screens/connectivity/message.dart';
import 'package:trapp_flutter/services/auth.dart';

import 'package:trapp_flutter/services/trips_service.dart';
import 'package:trapp_flutter/services/user_service.dart';

class LoadingTrips extends StatefulWidget {
  const LoadingTrips({Key? key}) : super(key: key);

  @override
  _LoadingTripsState createState() => _LoadingTripsState();
}

class _LoadingTripsState extends State<LoadingTrips> {
  late int start;
  final Trace myTrace = FirebasePerformance.instance.newTrace("Trips Activity");
  bool internetStatus = false;

  List<Place> places = [];
  List<Place> closePlaces = [];

  List<Trip> trips = [];
  List<Trip> affordableActivities = [];

  double budget = 20000000.0;
  double latitude = 0.0;
  double longitude = 0.0;
  late String codeDialog;
  late String valueText;
  String keyWordFilter = '';

  final TextEditingController _textFieldController = TextEditingController();
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(25),
            actionsPadding: const EdgeInsets.all(10),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            elevation: 10,
            title: const Center(child: Text("What's your budget")),
            content: Neumorphic(
              style: NeumorphicStyle(
                depth: -8,
                boxShape:
                NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      valueText = value;
                    });
                  },
                  controller: _textFieldController,
                  decoration: const InputDecoration(hintText: "New Budget"),
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('OK'),
                onPressed: () {
                  setState(() {
                    budget = valueText as double;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void setLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    location.getLocation().then((ld) => setState(() {
      latitude = ld.latitude!;
      longitude = ld.longitude!;
    }));
  }

  @override
  void dispose() {
    myTrace.stop();
    UserService us = UserService(uid: '');
    us.setTimeLoadingTime('Trips', (DateTime.now().millisecondsSinceEpoch - start) / 1000);
    super.dispose();
  }

  @override
  void initState() {
    myTrace.start();
    try {
      InternetAddress.lookup('firebase.google.com').then((result) {
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            internetStatus = true;
          });
        }
      });
    } on SocketException catch (_) {
      debugPrint('not connected to internet, socketException');
    }
    setState(() {
      start = DateTime.now().millisecondsSinceEpoch;
    });
    super.initState();
    setLocation();
    if (!internetStatus) {
      TripsService().getPlacesList().then((ps) {
        setState(() {
          places = ps;
        });
      });
      TripsService().getTripsList().then((ts) {
        setState(() {
          trips = ts;
        });
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    myTrace.stop();
    setState(() {
      closePlaces = places
          .where((p) =>
      p.distance(latitude, longitude) < 9 &&
          p.name.contains(keyWordFilter))
          .toList();
      affordableActivities = trips
          .where((t) => t.price <= budget
        // && t.name.contains(keyWordFilter)
      )
          .toList();
      // affordablePlaces = places.where((p) => p < 4).toList();
    });

    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      // physics: const BouncingScrollPhysics(),
      child: Container(
        width: size.width,
        // height: size.height,
        color: const Color(0xFFC7E7E9),

        padding: const EdgeInsets.fromLTRB(20, 30, 20, 45),
        // color: NeumorphicTheme.baseColor(context),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'Plan your trip',
                    style: TextStyle(
                      fontFamily: 'thaBold',
                      fontSize: 35,
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/logoTrapp.png'),
                    backgroundColor: Colors.transparent,
                    radius: 20,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Neumorphic(
                      style: NeumorphicStyle(
                          depth: -8,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(20))),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            keyWordFilter = value;
                          });
                        },
                        decoration: const InputDecoration(
                          // border: OutlineInputBorder(),
                          // contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            icon: Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: Icon(Icons.explore)),
                            hintText: 'Search'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          budget = 20000000;
                        });
                      },
                      icon: const Icon(Icons.filter_alt_outlined)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(" \u00240"),
                  Expanded(
                      child: Slider(
                        onChanged: (double value) {
                          setState(() {
                            budget = value;
                          });
                        },
                        divisions: 5,
                        max: 100000000,
                        min: 0,
                        value: budget,
                      )),
                  Text('\u0024${(budget / 1000).floor()}k'),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      color: Colors.blue,
                      onPressed: () {
                        _displayTextInputDialog(context);
                      },
                      icon: const Icon(Icons.edit)),
                ],
              ),
              const Text(
                'For your budget',
                style: TextStyle(
                  fontFamily: 'thaBold',
                  fontSize: 25,
                ),
              ),
              const Divider(
                height: 15,
              ),
              SizedBox(
                height: !internetStatus || trips.isEmpty ? 120 : 225,
                child: !internetStatus
                    ? const NoTripsInternet()
                    : trips.isEmpty
                    ? const SpinKitWave(
                  // SpinningLines(
                  color: Color(0xFF00AFB9),
                  size: 90.0,
                  // controller: AnimationController( duration: const Duration(milliseconds: 1200)),
                )
                    : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: affordableActivities.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      TripCard(trip: affordableActivities[index]),
                    );
                  },
                ),
              ),
              const Divider(
                height: 15,
              ),
              const Text(
                'Places near to you',
                style: TextStyle(
                  fontFamily: 'thaBold',
                  fontSize: 25,
                ),
              ),
              const Divider(
                height: 15,
              ),
              SizedBox(
                height: 225,
                child: places.isEmpty
                    ? const SpinKitWave(
                  // SpinningLines(
                  color: Color(0xFF00AFB9),
                  size: 90.0,
                  // controller: AnimationController( duration: const Duration(milliseconds: 1200)),
                )
                    : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: closePlaces.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PlaceCard(place: closePlaces[index]),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ]),
      ),
    );
  }
}

class PlaceCard extends StatelessWidget {
  final Place place;

  const PlaceCard({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("You have pressed ${place.img}")),
          );
        },
        child: SizedBox(
          width: 155,
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(place.img),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // child: Text(places[index].name)
                    child: const SizedBox(
                      width: 140,
                      height: 100,
                    ),
                  ),
                  const Divider(
                    height: 35,
                  ),
                  Neumorphic(
                    style: const NeumorphicStyle(depth: -5),
                    child: SizedBox(
                      width: 115,
                      height: 35,
                      // child: Center(child: Text(trip.price.toString())),
                      child: Center(child: Text(place.name)),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class TripCard extends StatelessWidget {
  final Trip trip;

  const TripCard({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("You have pressed ${trip.destination}")),
          );
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              TripDetail(trip: trip,),
          ),
          );
        },
        child: SizedBox(
          width: 155,
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(trip.img),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // child: Text(places[index].name)
                    child: const SizedBox(
                      width: 140,
                      height: 100,
                    ),
                  ),
                  const Divider(
                    height: 35,
                  ),
                  Neumorphic(
                    style: const NeumorphicStyle(depth: -5),
                    child: SizedBox(
                      width: 115,
                      height: 35,
                      // child: Center(child: Text(trip.price.toString())),
                      child: Center(
                          child: Text(
                              ' \u0024${NumberFormat("#,##0.00", "en_US").format(trip.price)}')),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
