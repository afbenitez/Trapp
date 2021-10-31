import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trapp_flutter/models/city.dart';
import 'package:trapp_flutter/models/item.dart';

class ItemService {


  final CollectionReference itemsCollection =
    FirebaseFirestore.instance.collection('items');


  List<Stream<Item>> getItems(List<DocumentReference> entities) {

    List<Stream<Item>> retVal = [];
    entities.forEach((element) {
      retVal.add(element.snapshots().map((_itemsListFromSnapshot)));
    });
    return retVal;
  }

  Item _itemsListFromSnapshot(DocumentSnapshot snapshot) {
    return Item(
      uid: snapshot.id,
      name: snapshot['name'],
    );
  }



}