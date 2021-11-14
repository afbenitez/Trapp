
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trapp_flutter/models/connectivity.dart';
import 'package:trapp_flutter/models/item.dart';
import 'package:trapp_flutter/services/user_service.dart';
import 'package:trapp_flutter/services/item_s.dart';
import 'items.dart';

class AllItems extends StatelessWidget {
  const AllItems({Key? key}) : super(key: key);
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


class _ItemsListState extends State<ItemsList> {

  var connection = false;
  OverlayEntry? entry;
  late StreamSubscription subscription;
  final Connectivity _connectivity = Connectivity();

  late int start;

  @override
  void initState() {
    super.initState();
    setState(() {
      start = DateTime.now().millisecondsSinceEpoch;
    });
    if(!connection) {
      ConnectivityStatus(connectivity: _connectivity, context: context, entry: entry).initConnectivity();
      connection = true;
    };

    subscription =
        Connectivity().onConnectivityChanged.listen( ConnectivityStatus(entry: entry, context: context, connectivity: _connectivity).showConnectivitySnackBar);
  }

  @override
  void dispose() {
    subscription.cancel();
    UserService us = UserService(uid: '');
    us.setTime('Item', (DateTime.now().millisecondsSinceEpoch-start)/1000);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<Item>>(context);
    bool isSwitched = true;


    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index){

        if(index <= 10){
          return Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            color: const Color(0xffEDD83D),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xffEEEEEE),
                backgroundImage: AssetImage("assets/logo.png"),
                radius: 23.0,
              ),
              title: Text(items[index].name),
              trailing: new Switch(
                value: true,
                activeColor: Colors.yellow,
                activeTrackColor: Colors.yellow,
                onChanged: (value){
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
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
                onChanged: (value){
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


