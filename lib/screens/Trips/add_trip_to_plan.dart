
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:trapp_flutter/models/plan.dart';
import 'package:trapp_flutter/models/trip.dart';
import 'package:trapp_flutter/models/user_fb.dart';
import 'package:trapp_flutter/services/plans_service.dart';

class AddTrip extends StatefulWidget {
  AddTrip({Key? key, required this.trip}) : super(key: key);

  final Trip trip;

  LocalStorage storage = LocalStorage('trapp_storage');

  @override
  _AddTripState createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {

  List<Plan> plans = [];
  @override
  void initState() {
    // final user = Provider.of<User_fb?>(context);
    PlanService().getPlansList().then((value){
      setState(() {
        plans = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: plans.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Text('trying: ${plans[index].name}'),
            );
          },
        ),
      ),
    );
  }
}

