import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trapp_flutter/screens/connectivity/message.dart';

class ConnectivityStatus {
  OverlayEntry? entry;
  BuildContext context;
  Connectivity connectivity;

  ConnectivityStatus({
    required this.entry,
    required this.context,
    required this.connectivity
  });

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await connectivity.checkConnectivity();

      if(result == ConnectivityResult.none){
        showOverlay();
      }
    } on PlatformException catch (e) {
      print(e.toString());
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