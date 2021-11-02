import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trapp_flutter/models/item.dart';
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
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<Item>>(context);
    bool isSwitched = false;

    bool state(){
      Random ran = new Random();
      return ran.nextBool();
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          color: const Color(0xff00AFB9),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xffEEEEEE),
              backgroundImage: AssetImage("assets/logo.png"),
              radius: 25.0,
            ),
            title: Text(items[index].name),
            trailing: new Switch(
              value: state(),
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
      },
    );
  }
}
