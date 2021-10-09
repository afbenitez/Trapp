import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trapp_flutter/models/city.dart';
import 'package:trapp_flutter/models/item.dart';

class CityService {
  final CollectionReference citiesCollection =
  FirebaseFirestore.instance.collection('cities');

  final CollectionReference itemsCollection =
  FirebaseFirestore.instance.collection('items');

  List<City> _citiesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      print(doc['items']);
      return City(
        uid: doc.id,
        name: doc['name'] ?? '',
        items: List.from(doc['items']),
      );
    }).toList();
  }

  Stream<List<City>> get cities {
    return citiesCollection.snapshots().map(_citiesListFromSnapshot);
  }

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


  Stream<DocumentSnapshot> getCity(String uid){
    return citiesCollection.doc(uid).snapshots();
  }

}
