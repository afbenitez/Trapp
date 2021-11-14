import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trapp_flutter/models/trip.dart';

class DatabaseService {
  //Collection reference for manipullating crud documents
  final CollectionReference placesCollection =
      FirebaseFirestore.instance.collection('places');
  final CollectionReference tripsCollection =
      FirebaseFirestore.instance.collection('trips');

  //Para llamar este metodo se invoca: await DatebaseService().updateUserDate(name)
  Future updateUserData(String name) async {
    return await placesCollection
      ..doc('uid').set({
        'attr1': 1,
        'attr2': '2',
        'attr1': 3,
        'attr1': name,
      });
  }

  //Brew list from snapshot
  List<Trip> _tripListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((d) {
      // print(d);
      return Trip(
          name: d.get('name') ?? 'Cartagena',
          img: d.get('img') ?? 'https://picsum.photos/300/200',
          reviews: d.get('reviews')!.length ?? 0,
          rating: d.get('reviews')[0]['califiction'] ?? 5,
          price: 0,
      );
    }).toList();
  }

  //get docs stream
  Stream<List<Trip>> get trips {
    return tripsCollection.snapshots()
    .map(_tripListFromSnapshot);
  }
}
