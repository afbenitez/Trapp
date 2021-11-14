import 'package:cloud_firestore/cloud_firestore.dart';
class UserService {

  final String uid;
  UserService({ required this.uid });

  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(String name) async {
    return await users.doc(uid).set({
      'name': name
    });
  }

}