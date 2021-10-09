import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trapp_flutter/models/city.dart';
import 'package:trapp_flutter/services/city_s.dart';

import 'items.dart';

class AllCities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<City>>.value(
      value: CityService().cities,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent[50],
        appBar: AppBar(
          title: Text('Cities'),
          backgroundColor: Colors.lightBlueAccent[300],
          elevation: 0.0,
        ),
        body: Container(child: CitiesList()),
      ),
    );
  }
}

class CitiesList extends StatefulWidget {
  @override
  _CitiesListState createState() => _CitiesListState();
}

class _CitiesListState extends State<CitiesList> {
  @override
  Widget build(BuildContext context) {
    final cities = Provider.of<List<City>>(context);

    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
            ),
            title: Text(cities[index].name),
            subtitle: Text('Items: ${cities[index].items[1]}'),
            onTap: () async {

            },
          ),
        );
      },
    );
  }
}
