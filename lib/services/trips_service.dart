import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trapp_flutter/models/trip.dart';

class TripsService {
  final CollectionReference tripsCollection =
  FirebaseFirestore.instance.collection('trips');

  //To call this method is executed: await TripService().updateTripData(tid, name)
  Future updateTripData(String tid, String name) async {
    return tripsCollection
      ..doc(tid).set({
        'attr1': 1,
        'attr2': '2',
        'attr3': 3,
        'attr4': name,
      });
  }

  //Brew list from snapshot
  List<Trip> _tripListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((d) {
      // print(d);
      return Trip(
          name: d.get('name') ?? 'Cartagena',
          img: d.get('img') ?? 'https://picsum.photos/300/200',
          reviews: d.get('reviews') ?? (d.get('reviews').length ?? 0),
          rating: d.get('reviews')[0]['califiction'] ?? 5);
    }).toList();
  }

  //get docs stream
  Stream<List<Trip>> get trips {
    return tripsCollection.snapshots()
        .map(_tripListFromSnapshot);
  }
}
