
import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceService{

  late final String uid;
  PlaceService({ required this.uid });

  final CollectionReference placesCollection =
  FirebaseFirestore.instance.collection('places');


}