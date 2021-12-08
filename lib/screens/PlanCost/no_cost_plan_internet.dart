import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NoCostPlanInternet extends StatelessWidget {
  const NoCostPlanInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: EdgeInsets.fromLTRB(100.0, 200.0, 100.0, 300.0),
      style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(35)),
          color: const Color(0xFFC7E7E9)
      ),

      child: Column(
        children: [
          NeumorphicIcon(
            Icons.signal_wifi_connected_no_internet_4_rounded,
            size: 55,
            style: const NeumorphicStyle(
                color: Color(0xFF00AFB9),
                depth: 5,
                intensity: 1
            ),
          ),
          const Text('Could not find internet connection \n try again', textAlign: TextAlign.center,)
        ],
      ),
    );


  }
}