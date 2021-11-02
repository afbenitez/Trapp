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
  final timer = TimeUsage();
  timer.start();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  timer.stop();
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

class TimeUsage{
  late DateTime startDateTime;
  final mainStreamController = StreamController<String>();
  final stateStreamController = StreamController<bool>();
  bool running = false;

  void start(){
    startDateTime = DateTime.now();
    running = true;
    stateStreamController.sink.add(true);

    Timer.periodic(Duration(milliseconds: 1), (timer) {
      if(!running){
        timer.cancel();
        return;
      }
      final time = DateTime.now();

    });
  }

  void stop(){
    running = false;
    stateStreamController.sink.add(false);
  }


}
