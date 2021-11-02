import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trapp_flutter/models/user_fb.dart';
import 'package:trapp_flutter/screens/Trips/loading_trips.dart';
import 'package:trapp_flutter/screens/home/home.dart';
import 'package:trapp_flutter/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trapp_flutter/services/auth.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User_fb?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
        routes: {
          '/trips' : (context) => const Text('Trips page'),
        },
      ),
    );
  }
}




