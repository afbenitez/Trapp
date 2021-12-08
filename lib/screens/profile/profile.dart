import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:localstorage/localstorage.dart';
import 'package:trapp_flutter/models/connectivity.dart';
import 'package:trapp_flutter/services/user_service.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String userId = '';
  String name = '';
  String lastName = '';
  String email = '';
  String phone = '';
  String birthday = '';
  String gender = '';
  List dailyExpenses = [];
  List usersGroup = [];

  OverlayEntry? entry;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription subscription;

  bool edit = false;
  bool internetStatus = false;
  bool connectivity = false;

  final LocalStorage storage = LocalStorage('trapp_storage');

  void initState(){

    try {
      InternetAddress.lookup('firebase.google.com').then((result) {
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            connectivity = true;
          });
        }
      });
    } on SocketException catch (_) {
      debugPrint('not connected to internet, socketException');
    }

    if(!internetStatus)
    {
      ConnectivityStatus(entry: entry, context: context, connectivity: _connectivity).initConnectivity();
      internetStatus = true;
    };
    subscription =
        Connectivity().onConnectivityChanged.listen(ConnectivityStatus(entry: entry, context: context, connectivity: _connectivity).showConnectivitySnackBar);

    super.initState();
      User? getUser = FirebaseAuth.instance.currentUser;
      var uid = getUser!.uid;
      var document =
      FirebaseFirestore.instance.collection('users').doc(uid);
      document.get().then((u) {
        setState(() {
          name = u.get('firstName');
          lastName = u.get('lastName');
          email = u.get('email');
          phone = u.get('phone');
          birthday = u.get('birthday');
          gender = u.get('gender');
          dailyExpenses = u.get('dailyExpenses');
          usersGroup = u.get('userGroup');
        });

        storage.setItem('firstName', name);
        storage.setItem('lastName', lastName);
        storage.setItem('birthday', birthday);
        storage.setItem('email', email);
        storage.setItem('phone', phone);
      });
  }

  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Container(
      color: Color(0xFFC7E7E9),
      child: Column(children: [
        Row(
          children: [
            SizedBox(
              width: size-50,
            ),
            Image(
              image: AssetImage('assets/logo.png'),
              width: 45,
              height: 45,
            ),
          ],
        ),
        SizedBox(
          height: size / 25,
        ),
        SingleChildScrollView(
          child: Container(
              width: size/3,
              height: size/3,
              decoration: BoxDecoration(
                color: Color(0xffeeeeee),
                shape: BoxShape.circle,
              ),
              child: Image(
                image: AssetImage('assets/user.png'),
              ),
            ),
        ),
        SizedBox(
          height: size/25,
        ),
        Text(
          '${storage.getItem('firstName')} ${storage.getItem('lastName')}',
          style: TextStyle(
            fontFamily: 'thaRegular',
            fontSize: 25,
          ),
        ),
        SizedBox(
          height: size/15,
        ),
        SingleChildScrollView(
          child: Neumorphic(
            child: Container(
              color: Color(0xffeeeeee),
              height: size*1.2,
              width: size/1.2,
              child: Column(
                children: [
                  SizedBox(
                    height: size/25,
                  ),
                  Text(
                    'Personal information',
                    style: TextStyle(
                      fontFamily: 'thaBold',
                      fontSize: size/15,
                    ),
                  ),
                  SizedBox(
                    height: size/25,
                  ),
                  Text(
                    'Birthday',
                    style: TextStyle(
                      fontFamily: 'thaRegular',
                      fontSize: size/18,
                    ),
                  ),
                  SizedBox(
                    height: size/30,
                  ),
                  Neumorphic(
                    style: const NeumorphicStyle(depth: -8),
                    child: SizedBox(
                      height: size/10,
                      width: size/1.5,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            birthday = value;
                            storage.setItem('birthday', birthday);
                          });
                        },
                        enabled: edit,
                        decoration: InputDecoration(
                          hintText: '${storage.getItem('birthday')}',
                          hintStyle: TextStyle(
                            fontFamily: 'thaRegular',
                            fontSize: size/20,

                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size/25,
                  ),
                  Text(
                    'Email',
                    style: TextStyle(
                      fontFamily: 'thaRegular',
                      fontSize: size/18,
                    ),
                  ),
                  SizedBox(
                    height: size/30,
                  ),
                  Neumorphic(
                    style: const NeumorphicStyle(depth: -8),
                    child: SizedBox(
                      height: size/10,
                      width: size/1.5,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            email = value;
                            storage.setItem('email', email);
                          });
                        },
                        enabled: edit,
                        decoration: InputDecoration(
                          hintText: '${storage.getItem('email')}',
                          hintStyle: TextStyle(
                            fontFamily: 'thaRegular',
                            fontSize: size/20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size/25,
                  ),
                  Text(
                    'Phone',
                    style: TextStyle(
                      fontFamily: 'thaRegular',
                      fontSize: size/18,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: size/30,
                  ),
                  Neumorphic(
                    style: const NeumorphicStyle(depth: -8),
                    child: SizedBox(
                      height: size/10,
                      width: size/1.5,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            phone = value;
                            storage.setItem('birthday', phone);
                          });
                        },
                        enabled: edit,
                        decoration: InputDecoration(
                          hintText: '${storage.getItem('phone')}',
                          hintStyle: TextStyle(
                            fontFamily: 'thaRegular',
                            fontSize: size/20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size/10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Opacity(
                        opacity: connectivity ? 1.0 : 0.2,
                        child: RaisedButton(
                            onPressed: () {
                                  editProfile();
                            },
                            color: Color(0xffEDD83D),
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              fontFamily: 'thaBold',
                              fontSize: size/20,
                              color: Color(0xff481620)
                            ),
                          ),
                          ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Opacity(
                        opacity: edit ? 1.0 : 0.2,
                        child: RaisedButton(
                          onPressed: () {
                            UserService(uid: userId).updateUserData(
                                name, lastName, phone, birthday, email, gender, dailyExpenses, usersGroup);
                            setState(() {
                              edit = false;
                            });
                        },
                          color: Color(0xff02B0BA),

                          child: Text(
                            'Save',
                            style: TextStyle(
                                fontFamily: 'thaBold',
                                fontSize: size/20,
                                color: Color(0xFFFFFFFF)
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void editProfile(){
    setState(() {
      edit = true;
    });
  }
}
