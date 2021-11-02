import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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

  Future updateGroups(String uid, int numberMembers, int totalBudget) async{
    CollectionReference groups = FirebaseFirestore.instance.collection('userGroup');
    return await groups.doc(uid).set({
      'numberMembers': numberMembers,
      'totalBudget': totalBudget
    });
  }

}