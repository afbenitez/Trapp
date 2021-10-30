import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:location/location.dart';
import 'package:trapp_flutter/models/place.dart';
import 'package:trapp_flutter/models/trip.dart';
import 'package:trapp_flutter/services/auth.dart';
import 'package:trapp_flutter/services/trips_service.dart';

class LoadingTrips extends StatefulWidget {
  const LoadingTrips({Key? key}) : super(key: key);

  @override
  _LoadingTripsState createState() => _LoadingTripsState();
}

class _LoadingTripsState extends State<LoadingTrips> {
  final AuthService _auth = AuthService();

  List<Place> places = [];
  List<Place> closePlaces = [];

  List<Trip> trips = [];
  // List<Place> affordablePlaces = [];

  double budget = 0.0;
  double latitude = 0.0;
  double longitude = 0.0;
  late String codeDialog;
  late String valueText;

  final TextEditingController _textFieldController = TextEditingController();
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 20,
            title: const Text("What's your budget"),
            content: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "New Budget"),
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
  void initState() {
    super.initState();
    setLocation();
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
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      closePlaces =
          places.where((p) => p.distance(latitude, longitude) < 20).toList();
      // affordablePlaces = places.where((p) => p < 4).toList();
    });

    return places.isEmpty
        ? const CircularProgressIndicator(
            strokeWidth: 5.0,
          )
        : Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/imgHome.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(25, 35, 25, 0),
            // color: NeumorphicTheme.baseColor(context),
            child: Column(
              mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text('Plan your trip'),
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
                          child: const TextField(
                            decoration: InputDecoration(
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
                              budget -= 1;
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
                        max: 10000000,
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
                            setState(() {
                              budget += 1;
                            });
                          },
                          icon: const Icon(Icons.edit)),
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => SizedBox(
                                height: 150,
                                width: 150,
                                child: AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                  ),
                                  title: const Text('Set your new budget'),
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Neumorphic(
                                        style: NeumorphicStyle(
                                          depth: -8,
                                          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 50),
                                          child: TextField(

                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        child: Neumorphic(
                                          style: NeumorphicStyle(
                                            boxShape: NeumorphicBoxShape.roundRect(
                                                const BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight: Radius.circular(15)
                                            ))
                                          ),
                                          child: const Text(
                                            "Rate Product",
                                            style: TextStyle(color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const Text('Dialog')),
                    ],
                  ),
                  const Divider(
                    height: 15,
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: trips.length,
                      itemBuilder: (context, index) {
                        return TripCard(trip: trips[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 15,
                        );
                      },
                    ),
                  ),
                  const Divider(
                    height: 15,
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: closePlaces.length,
                      itemBuilder: (context, index) {
                        return PlaceCard(place: closePlaces[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 15,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ]),
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
                  Text(place.name),
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
            SnackBar(content: Text("You have pressed ${trip.img}")),
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
                  Text(trip.name),
                ],
              )),
        ),
      ),
    );
  }
}
