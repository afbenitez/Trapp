import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:trapp_flutter/screens/connectivity/message.dart';

class ConnectivityStatus {
  OverlayEntry? entry;
  BuildContext context;

  ConnectivityStatus({
    required this.entry,
    required this.context
  });

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