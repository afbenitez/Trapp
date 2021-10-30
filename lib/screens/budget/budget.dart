import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:trapp_flutter/screens/budget/heading.dart';
import 'package:trapp_flutter/services/auth.dart';


final AuthService _auth = AuthService();

class Budget extends StatelessWidget{

  const Budget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return
      circularBar(context);
  }

  Widget circularBar(BuildContext context){

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffEEEEEE),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: <Widget>[
                Heading(),
                           SizedBox(
                             height: MediaQuery.of(context).size.height/25,
                           ),
                           LinearPercentIndicator(
                             progressColor: Color(0xff00AFB9),
                              backgroundColor: Colors.transparent,
                              lineHeight: 10,
                              percent: 200000/2000000,
                              animation: true,
                              animationDuration: 4000,
                              leading: Text(
                                'day 1',
                                style: TextStyle(
                                  fontFamily: 'thaRegular',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              trailing: Text(
                                '200.000',
                                style: TextStyle(
                                  fontFamily: 'thaRegular',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/35,
                ),
                          LinearPercentIndicator(
                            progressColor: Color(0xff00AFB9),
                            backgroundColor: Colors.transparent,
                            lineHeight: 10,
                            percent: 550000/2000000,
                            animation: true,
                            animationDuration: 4000,
                            leading: Text(
                              'day 2',
                              style: TextStyle(
                                fontFamily: 'thaRegular',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            trailing: Text(
                              '550.000',
                              style: TextStyle(
                                fontFamily: 'thaRegular',
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),)
                    ),
                  ),
            );
  }
}

