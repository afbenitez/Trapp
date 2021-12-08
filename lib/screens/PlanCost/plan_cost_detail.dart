  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter/material.dart';
  import 'package:intl/intl.dart';
  import 'package:provider/provider.dart';
  import 'package:trapp_flutter/models/plan.dart';

  import 'package:trapp_flutter/screens/Trips/add_trip_to_plan.dart';
  import 'package:trapp_flutter/services/plans_service.dart';


  class PlanCostDetail extends StatelessWidget {
    const PlanCostDetail({Key? key, required this.plan}) : super(key: key);

    final Plan plan;

    @override
    Widget build(BuildContext context) {

      return  Scaffold(

          backgroundColor: const Color(0xffEEEEEE),
          appBar: AppBar(
            centerTitle: true,
            title: Text('Estimated cost for the plans'),
            backgroundColor: const Color(0xff00AFB9),
            elevation: 0.0,
          ),
          body: ListView.builder(
                  itemCount: plan.trips.length,
                  itemBuilder: (context, index) {
                    int x = plan.trips[index]['price'];
                    return  Card(
                        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                        child:  ListTile(
                          title: Text(plan.trips[index]['name'] ),
                          leading: Icon(Icons.star_border),
                          subtitle: Text("Costo aproximado: $x COP" ),
                        ),
                      );
                  },
                ),

      );
    }
  }




