import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trapp_flutter/models/activity.dart';

class ActivityService{

  final CollectionReference activities = FirebaseFirestore.instance.collection('activities');

  //Brew list from snapshot
  List<Activity> _activityFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((d) {
      // print(d);
      return Activity(
          endDate: d.get('endDate'), 
          name: d.get('name'), 
          price: d.get('price'), 
          startDate: d.get('startDate'), 
          type: d.get('type'));
    }).toList();
  }

  //get docs stream
  Stream<List<Activity>> get trips {
    return activities.snapshots().map(_activityFromSnapshot);
  }

  Future<List<Activity>> getActivityList() async {
    QuerySnapshot qs = await activities.get();
    return qs.docs
        .map((t) => Activity.fromData({
      'endDate': t.get('endDate'),
      'name': t.get('name'),
      'price': t.get('price'),
      'startDate': t.get('startDate'),
      'type': t.get('type')
    }))
        .toList();
  }

}