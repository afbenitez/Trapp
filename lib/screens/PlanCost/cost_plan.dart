import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:trapp_flutter/models/connectivity.dart';
import 'package:trapp_flutter/models/item.dart';
import 'package:trapp_flutter/screens/connectivity/no_internet.dart';
import 'package:trapp_flutter/services/user_service.dart';
import 'package:trapp_flutter/services/item_s.dart';

import 'no_cost_plan_internet.dart';




class costPlan extends StatelessWidget {
  const costPlan({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Item>>.value(
      value: ItemService().items,
      initialData: [],
      child: Scaffold(
        backgroundColor: const Color(0xffEEEEEE),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Suggested Items'),
          backgroundColor: const Color(0xff00AFB9),
          elevation: 0.0,
        ),
        body: Container(child: ItemsList()),
      ),
    );
  }
}

class ItemsList extends StatefulWidget {
  @override
  _ItemsListState createState() => _ItemsListState();
}


class _ItemsListState extends State<ItemsList>{

  var connection = false;
  OverlayEntry? entry;
  late StreamSubscription subscription;
  final Connectivity _connectivity = Connectivity();

  late int start;

  final Trace myTrace = FirebasePerformance.instance.newTrace("Item Activity");

  final LocalStorage storage = LocalStorage('trapp_storage');

  bool internetStatus = false;

  List<Item> items = [];


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

       ItemService().getItems().then((ts) {
         setState(() {


           items = ts!;
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
    us.setTimeLoadingTime('Items', (DateTime.now().millisecondsSinceEpoch - start) / 1000);

    final items = Provider.of<List<Item>>(context);
    bool isSwitched = true;

    if (!internetStatus)
      return const NoCostPlanInternet();
    else {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          if (index <= 10) {
            return Card(
              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
              color: const Color(0xffEDD83D),
              child:  ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xffEEEEEE),
                  backgroundImage: AssetImage("assets/logo.png"),
                  radius: 23.0,
                ),
                title: Text(items[index].name),
              ),
            );
          }

          else {
            return Card(
              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
              color: const Color(0xff00AFB9),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xffEEEEEE),
                  backgroundImage: AssetImage("assets/logo.png"),
                  radius: 23.0,
                ),
                title: Text(items[index].name),
                trailing: new Switch(
                  value: false,
                  activeColor: Colors.yellow,
                  activeTrackColor: Colors.yellowAccent,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
              ),
            );
          }
        },
      );
    }
  }
}