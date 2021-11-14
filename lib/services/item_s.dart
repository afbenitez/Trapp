import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trapp_flutter/models/item.dart';

class ItemService{
  final CollectionReference itemsCollection = FirebaseFirestore.instance.collection('items');

  List<Item> _itemsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Item(
        uid: doc.id,
        name: doc['name'] ?? '',
      );
    }).toList();
  }

  Stream<List<Item>> get items {
    return itemsCollection.snapshots().map(_itemsListFromSnapshot);
  }


}

