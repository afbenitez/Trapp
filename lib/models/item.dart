import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String uid;
  final String name;

  Item({ required this.name,required this.uid});

  factory Item.fromData(Map data) {
    return Item(
      name: data["name"] ?? "",
      uid: data["uid"] ?? "",
    );
  }
}