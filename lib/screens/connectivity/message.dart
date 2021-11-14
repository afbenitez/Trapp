import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class InternetMessage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Neumorphic(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NeumorphicIcon(
                    Icons.wifi_off_rounded,
                    size: 60,
                    style: const NeumorphicStyle(
                        color: Color(0xFF00AFB9),
                        depth: 5,
                        intensity: 1
                    ),
                  ),
                  const Text(
                    'There is no an active \n connection please try again',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
  }
}