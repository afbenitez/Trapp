import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:trapp_flutter/screens/connectivity/no_internet.dart';
import 'package:trapp_flutter/screens/connectivity/message.dart';


class Connection extends StatelessWidget {
  static final String title = 'Has internet?';

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          home: MainPage(title: title),
        ));
  }
}

class MainPage extends StatefulWidget{

  final String title;

  const MainPage({
    required this.title
  });

  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{
  late StreamSubscription subscription;
  late StreamSubscription _subscription;
  OverlayEntry? entry;

  bool isOnline = false;

  @override
  void initState() {
    super.initState();

    if(!isOnline){
      checkConnectionStatus();
      isOnline = true;
      print('esta entrando acá');
      print(isOnline);
    }

    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);


  }

  @override
  void dispose() {
    subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(padding: EdgeInsets.all(12)),
          child: Text('Check Connection', style: TextStyle(fontSize: 20)),
          onPressed: () async {
            final result = await Connectivity().checkConnectivity();
            showConnectivitySnackBar(result);
          },
        ),
      ),
    );
  }

  void checkConnectionStatus( ){
    if( Connectivity().checkConnectivity() != ConnectivityResult.none){
        print('ups no internet');
        WidgetsBinding.instance!.addPostFrameCallback((_)=> showOverlay());
    } else {
      print('yes internet');
    }
  }

  void showConnectivitySnackBar(ConnectivityResult result) {

    if( result == ConnectivityResult.none){
      showOverlay();
    }
  }

  showOverlay() async {
    final overlay = Overlay.of(context)!;
    final renderbox = context.findRenderObject() as RenderBox;
    final size = renderbox.size;

    entry = OverlayEntry(
        builder: (context) => Positioned(
          width: size.width,
          child: InternetMessage(),
        ),
    );
    overlay.insert(entry!);

    await Future.delayed(Duration(seconds: 3));

    entry!.remove();

  }
  

}
