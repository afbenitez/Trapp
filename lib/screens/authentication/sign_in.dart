import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trapp_flutter/models/connectivity.dart';
import 'package:trapp_flutter/screens/connectivity/message.dart';
import 'package:trapp_flutter/services/auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:trapp_flutter/services/user_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.analytics,
    required this.observer,}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  // Checking connectivity
  OverlayEntry? entry;
  late StreamSubscription subscription;
  var connection = false;
  final Connectivity _connectivity = Connectivity();
  late int start;

  final Trace myTrace = FirebasePerformance.instance.newTrace("SingIn Activity");

  @override
  void initState() {
    super.initState();

    myTrace.start();
    setState(() {
      start = DateTime.now().millisecondsSinceEpoch;
    });

    if(!connection)
    {
        ConnectivityStatus(entry: entry, context: context, connectivity: _connectivity).initConnectivity();
        connection = true;
    };
    subscription =
        Connectivity().onConnectivityChanged.listen(ConnectivityStatus(entry: entry, context: context, connectivity: _connectivity).showConnectivitySnackBar);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    myTrace.stop();
    UserService us = UserService(uid: '');
    us.setTimeLoadingTime('Items', (DateTime.now().millisecondsSinceEpoch - start) / 1000);

    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgSignIn.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: _content(),
          ),
        ));
  }

  Widget _content() {
    return Container(
      padding: const EdgeInsets.all(22),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(
                  'TRAPP',
                  style: TextStyle(
                    fontFamily: 'trapp',
                    fontSize: MediaQuery.of(context).size.width / 4,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.all(34),
                decoration: const BoxDecoration(
                    color: Color(0xffF3F3F3),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 3,
                        blurRadius: 10,
                      )
                    ]),
                child: Column(
                  children: [
                 Text(
                        "Welcome!",
                        style: TextStyle(
                          fontFamily: 'thaBold',
                          fontSize: MediaQuery.of(context).size.width / 7,
                          color: const Color(0xff7B767D),
                        ),
                      ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.account_circle_rounded,
                            color: Colors.grey),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            )),
                        disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade50,
                        ),
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      obscureText: true,
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            )),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Color(0x808A8A82),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    RaisedButton(
                      onPressed: () async {

                        if(Connectivity().checkConnectivity() == ConnectivityResult.none){
                          ConnectivityStatus(connectivity: _connectivity, entry: entry, context: context).showOverlay();
                        } else {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                'Could not sign in with those credentials';
                              });
                            } else {
                              Navigator.pop(context);
                              await widget.analytics.logEvent(name: 'inicioSesion', parameters: <String, dynamic>{
                                'email': email
                              });
                            }
                          }
                        }
                      },
                      color: const Color(0xff00AFB9),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: const Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Color(0xffF3F9E3)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
