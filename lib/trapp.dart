import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trapp_flutter/models/user_fb.dart';
import 'package:trapp_flutter/screens/Trips/loading_trips.dart';
import 'package:trapp_flutter/screens/home/home.dart';
import 'package:trapp_flutter/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trapp_flutter/services/auth.dart';


import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pedantic/pedantic.dart';

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

void myLog(String msg) {
  print('My Log: $msg');
}

class _MetricHttpClient extends BaseClient {
  _MetricHttpClient(this._inner);

  final Client _inner;

  @override
  Future<StreamedResponse> send(BaseRequest request) async {

    final HttpMetric metric = FirebasePerformance.instance
        .newHttpMetric(request.url.toString(), HttpMethod.Get);

    await metric.start();

    StreamedResponse response;
    try {
      response = await _inner.send(request);
      myLog(
          'Called ${request.url} with custom monitoring, response code: ${response.statusCode}');

      metric
        ..responsePayloadSize = response.contentLength
        ..responseContentType = response.headers['Content-Type']
        ..requestPayloadSize = request.contentLength
        ..httpResponseCode = response.statusCode;

      await metric.putAttribute('score', '15');
      await metric.putAttribute('to_be_removed', 'should_not_be_logged');
    } finally {
      await metric.removeAttribute('to_be_removed');
      await metric.stop();
    }

    unawaited(metric
        .getAttributes()
        .then((attributes) => myLog('Http metric attributes: $attributes')));

    String? score = metric.getAttribute('score');
    myLog('Http metric score attribute value: $score');

    return response;
  }
}




