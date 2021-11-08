import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NeumorphicIcon(
          Icons.wifi_off_rounded,
          size: 200,
          style: const NeumorphicStyle(
              color: Color(0xFF00AFB9),
              depth: 5,
              intensity: 1
          ),
        ),
        const Text(
            'There is no an active connection \n try again',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFFAAAAAA)),
        ),
      ],
    );
  }
}
