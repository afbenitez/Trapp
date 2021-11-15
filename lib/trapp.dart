import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trapp_flutter/models/user_fb.dart';
import 'package:trapp_flutter/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trapp_flutter/services/auth.dart';


<<<<<<< HEAD
=======
import 'dart:async';

import 'package:firebase_performance/firebase_performance.dart';
import 'package:http/http.dart';
import 'package:pedantic/pedantic.dart';
>>>>>>> 50e758690f8ed5b9b59dbc8fc20d0bc1a531fa42

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User_fb?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        navigatorObservers: <NavigatorObserver>[observer],
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
        routes: {
          '/trips' : (context) => const Text('Trips page'),
        },
      ),
    );
  }
}







