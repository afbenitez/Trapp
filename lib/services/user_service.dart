import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trapp_flutter/models/dailyExpenses.dart';
class UserService {

  final String uid;
  UserService({ required this.uid });

  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  String  name = '';
  String  lastName = '';
  String  phone = '';
  String  birthday = '';
  String  email = '';
  String  gender = '';
  List dailyExpenses = [];
  List    userGroups=[];

  Future<void> updateUserData(
      String name, String lastName, String phone, String birthday, String email, String gender, List dailyExpenses, List userGroups) async {
    return await users.doc(uid).set({
      'firstName': name,
      'lastName': lastName,
      'phone': phone,
      'birthday': birthday,
      'email': email,
      'gender': gender,
      'dailyExpenses': dailyExpenses,
      'userGroups': userGroups
    });
  }

  getUser()async{
    List data = [];
    var documentSnapshot = await users.doc(uid).get();
    return data;
  }

}