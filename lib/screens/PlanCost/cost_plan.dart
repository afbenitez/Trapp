import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:trapp_flutter/models/connectivity.dart';
import 'package:trapp_flutter/models/plan.dart';

import 'package:trapp_flutter/screens/connectivity/no_internet.dart';
import 'package:trapp_flutter/services/plans_service.dart';
import 'package:trapp_flutter/services/user_service.dart';


import 'no_cost_plan_internet.dart';




class costPlan extends StatelessWidget {
  const costPlan({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Plan>>.value(
      value: PlanService().plans,
      initialData: [],
      child: Scaffold(
        backgroundColor: const Color(0xffEEEEEE),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Estimated cost for the plans'),
          backgroundColor: const Color(0xff00AFB9),
          elevation: 0.0,
        ),
        body: Container(child: PlansList()),
      ),
    );
  }
}

class PlansList extends StatefulWidget {
  @override
  _PlansListState createState() => _PlansListState();
}


class _PlansListState extends State<PlansList>{

  var connection = false;
  OverlayEntry? entry;
  late StreamSubscription subscription;
  final Connectivity _connectivity = Connectivity();

  late int start;

  final Trace myTrace = FirebasePerformance.instance.newTrace("Item Activity");

  final LocalStorage storage = LocalStorage('trapp_storage');

  bool internetStatus = false;

  List<Plan> plans = [];


  @override
  void initState()  {
     myTrace.start();
    try {
      InternetAddress.lookup('firebase.google.com').then((result) {
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(()  {
            internetStatus =  true;
          });
        }
      });
    } on SocketException catch (_) {
      debugPrint('not connected to internet, socketException');
    }
    setState(()  {
      start =  DateTime.now().millisecondsSinceEpoch;
    });
    super.initState();
     if (!internetStatus) {
       PlanService().getPlansList().then((value) {
         setState(() {
           plans = value;
         });
       });
     }
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context)  {
    myTrace.stop();
    UserService us = UserService(uid: '');
    us.setTimeLoadingTime('Plans', (DateTime.now().millisecondsSinceEpoch - start) / 1000);
    
    bool isSwitched = true;


    if (!internetStatus)
      return const NoCostPlanInternet();
    else {
      return ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {

            return Card(
              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
              color: const Color(0xFFC7E7E9),
              child:  ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xffEEEEEE),
                  backgroundImage: AssetImage("assets/logo.png"),
                  radius: 23.0,
                ),
                title: Text(plans[index].name),
              ),
            );


        },
      );
    }
  }
}