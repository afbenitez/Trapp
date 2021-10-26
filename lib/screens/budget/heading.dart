import 'package:flutter/material.dart';

class Heading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = 130.0;
    return Container(
        child: Column(
            children: [
              Container(
                alignment: Alignment.topRight,
                child: Image(
                  image: AssetImage('assets/logo.png'),
                  width: 60,
                  height: 60,
                ),
              ),
              Text(
                'How is my budget?',
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'thaBold',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 30,
              ),
              Text(
                'Total budget spent',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'thaBold',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 25,
              ),
        TweenAnimationBuilder(
          tween: Tween( begin: 0.0, end: 1.0),
          duration: Duration(seconds: 4,),
          builder: (context, double value, child){
            value = 1700000/2300000;
            int percentage = (value*100).ceil();
            return Container(
              height: size,
              width: size,
              child: Stack(
                children: [
                  ShaderMask(
                    shaderCallback: (rect){
                      return SweepGradient(
                          startAngle: 0.0,
                          endAngle: 3.14*2,
                          stops: [ value, value ],
                          center: Alignment.center,
                          colors: [
                            Color(0xff00AFB9),
                            Color(0xffEEEEEE),
                          ]
                      ).createShader(rect);
                    },
                    child: Container(
                      height: size,
                      width: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: size-30,
                      width: size-30,
                      decoration: BoxDecoration(
                        color: Color(0xffEEEEEE),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          height: size-55,
                          width: size-55,
                          decoration: BoxDecoration(
                            color: Color(0xffEEEEEE),
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.grey.shade300,
                                Colors.grey.shade200,
                                Colors.grey.shade100,
                                Colors.grey.shade50,
                                Colors.white,
                              ],
                              stops: [
                                0.3,
                                0.45,
                                0.6,
                                0.75,
                                0.9,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffEEEEEE),
                                blurRadius: 1.5,
                                spreadRadius: 5,
                                offset: Offset(2,2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '$percentage%',
                              style: TextStyle(
                                  fontSize: size-100,
                                  fontFamily: 'thaBold',
                                  color: Color(0xff687890)
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
              SizedBox(
                height: MediaQuery.of(context).size.height/35,
              ),
              Text(
                '1.700.000 COP / 2.300.000 COP',
                style: TextStyle(
                  fontFamily: 'thaRegular',
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/35,
              ),
              Text(
                'Daily expenditures',
                style: TextStyle(
                  fontFamily: 'thaBold',
                  fontSize: 20,
                ),
              ),]
        ),
    );
  }
}


