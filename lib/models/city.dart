import 'package:cloud_firestore/cloud_firestore.dart';

class City {
  final String uid;
  final String name;
  final List<DocumentReference> items;

  City({ required this.uid, required this.name, required this.items});
}