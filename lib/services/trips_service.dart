import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trapp_flutter/models/place.dart';
import 'package:trapp_flutter/models/trip.dart';

class TripsService {
  final CollectionReference tripsCollection =
      FirebaseFirestore.instance.collection('trips');

  final CollectionReference placesCollection =
      FirebaseFirestore.instance.collection('places');

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
          rating: d.get('reviews')[0]['califiction'] ?? 5,
          price: 0,
      );
    }).toList();
  }

  //get docs stream
  Stream<List<Trip>> get trips {
    return tripsCollection.snapshots().map(_tripListFromSnapshot);
  }

  Future<List<Trip>> getTripsList() async {
    QuerySnapshot qs = await tripsCollection.get();
    return qs.docs
        .map((t) => Trip.fromData({
              'name': t.get('name')??'trip',
              'img': t.get('img')??'https://picsum.photos/300/200',
              'reviews': t.get('reviews')!.length,
              'rating': t.get('reviews')[0]['califiction'],
              'price': t.get('price'),
              'activity': t.get('activity') ?? 'activity_1'
            }))
        .toList();
  }

  Future<List<Place>> getPlacesList() async {
    QuerySnapshot qs = await placesCollection.get();
    // qs.docs.forEach((element) {
    //   print(element.data());
    // });
    return qs.docs
        .map((e) => Place.fromData({
              'name': e.get('name'),
              'address': e.get('address'),
              'img': e.get('img'),
              'latitude': e.get('latitude'),
              'longitude': e.get('longitude'),
            }))
        .toList();
    // return [];
  }
}
