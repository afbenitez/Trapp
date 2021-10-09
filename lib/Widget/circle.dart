import 'package:flutter/material.dart';

class Circulo extends StatelessWidget {
  final double size;

  Circulo({ required this.size}) : assert(size!= null && size>0);

  Widget build(BuildContext context){
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Color(0xffEEEEEE),
        shape: BoxShape.circle,
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Container(
            child: Positioned(
              top: 300,
              child: Image.asset('assets/logo.png'),
            ),
          ),
        ],
      )

    );
  }
}