import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:trapp_flutter/models/place.dart';
import 'package:trapp_flutter/models/plan.dart';
import 'package:trapp_flutter/models/trip.dart';

class PlanService {
  final CollectionReference plansCollection =
      FirebaseFirestore.instance.collection('plans_trips');

  List<Plan> _plansListFromSnapshot(QuerySnapshot snapshot) {
    return  snapshot.docs.map((doc) {
      return Plan(
        id: doc.id,
        name: doc['name'] ?? '',
        user_id: doc["user_id"]?? '',
        city_name: doc["city_name"] ?? '',
        img: doc["img"] ?? '',
        trips: doc["trips"]?? [],
        reviews: doc["reviews"] ?? "",
        price: doc["price"] ?? 0,
      );
    }).toList();
  }
  Stream<List<Plan>> get plans {
    return  plansCollection.snapshots().map(_plansListFromSnapshot);
  }

  //To call this method is executed: await PlanService().updateTripData(tid, name)
  Future updatePlanData(String pid, String name) async {
    return plansCollection
      ..doc(pid).set({
        'attr1': 1,
        'attr2': '2',
        'attr3': 3,
        'attr4': name,
      });
  }

  Future<List<Plan>> getPlansList() async {
    QuerySnapshot qs = await plansCollection.get();
    // print('trying to acced plans');
    // qs.docs.forEach((element) {print(element.data());});
    return qs.docs.map((p) {
      List trips;
      try {
        trips = p.get('trips');
      } catch (e) {
        trips = [];
      }
      return Plan.fromData({
        'id': p.id,
        'name': p.get('name') ?? 'Usuario',
        'user_id': p.get('user') ?? 'aWkxfyH1loh5nr6bWDO1Cc6ZLoa2',
        'city_name': p.get('city')!['city_name'] ?? 'Bogota',
        'img': p.get('image') ?? 'https://picsum.photos/300/200',
        'trips': trips,
        'reviews': p.get('reviews'),
        'price': p.get('price'),
      });
    }).toList();
  }

  Future<List<Plan>> getPlansListByUser(String uid) async {
    QuerySnapshot qs = await plansCollection.where('user', isEqualTo: uid).get();
    // print('trying to acced plans');
    // qs.docs.forEach((element) {print(element.data());});
    return qs.docs.map((p) {
      List trips;
      try {
        trips = p.get('trips');
      } catch (e) {
        trips = [];
      }
      return Plan.fromData({
        'id': p.id,
        'name': p.get('name') ?? 'Usuario',
        'user_id': p.get('user') ?? 'aWkxfyH1loh5nr6bWDO1Cc6ZLoa2',
        'city_name': p.get('city')!['city_name'] ?? 'Bogota',
        'img': p.get('image') ?? 'https://picsum.photos/300/200',
        'trips': trips,
        'reviews': p.get('reviews'),
        'price': p.get('price'),
      });
    }).toList();
  }
}
