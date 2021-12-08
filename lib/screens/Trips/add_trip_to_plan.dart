import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:trapp_flutter/models/plan.dart';
import 'package:trapp_flutter/models/trip.dart';
import 'package:trapp_flutter/services/plans_service.dart';

class AddTrip extends StatefulWidget {
  const AddTrip({Key? key, required this.trip}) : super(key: key);

  final Trip trip;

  @override
  _AddTripState createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  List<Plan> plans = [];
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    PlanService().getPlansListByUser(user!.uid).then((value) {
      setState(() {
        plans = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add the trip to your plan!'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8,8,8,0),
        child: ListView.builder(
          itemCount: plans.length,
          itemBuilder: (BuildContext context, int index) {
            return NeumorphicButton(
              onPressed: (){
                List newTrips = plans[index].trips;
                newTrips.add(widget.trip.toJSONEncodable());
                PlanService().updatePlanData(plans[index].id, newTrips);
                Navigator.of(context).pop(widget.trip.name);
              },
                style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                ),
                child: IntrinsicWidth(
                    child: SizedBox(
                      height: 55,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(plans[index].name),
                            const Divider(
                              height: 5,
                            ),
                            Text('Price: ${plans[index].price}'),
                          ],
                        ),
                      ),
                    ),
                ),
              );
          },
        ),
      ),
    );
  }
}
