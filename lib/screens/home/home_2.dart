import "package:flutter/material.dart";
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:trapp_flutter/screens/authentication/sign_in.dart';
// import 'package:trapp_flutter/screens/authentication/sign_in_2.dart';
import 'package:trapp_flutter/screens/authentication/sign_up_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/imgHome.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Center(
                  child: Text(
                    'TRAPP',
                    style: TextStyle(
                      fontFamily: 'trapp',
                      fontSize: 85,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Neumorphic(
                  style: NeumorphicStyle(
                    intensity: 1,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(20)),
                      color: NeumorphicColors.background),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Neumorphic(
                            style: NeumorphicStyle(
                              color: Colors.grey[350],
                              boxShape: const NeumorphicBoxShape.circle(),
                              depth: -20,
                              intensity: 1
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(20),
                              child: CircleAvatar(
                                backgroundImage: AssetImage('assets/logoTrapp.png'),
                                backgroundColor: Colors.transparent,
                                radius: 80,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          SizedBox(
                            width: 220,
                              height: 45,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff00AFB9)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18.0),
                                          )
                                      )
                                  ),
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute( builder: (context) => const SignIn() ),
                                    );
                                  },
                                  child: const Text("Login")
                              ),
                          ),
                          SizedBox(
                            width: 220,
                            height: 45,
                            child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffEDD83D)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                        )
                                    )
                                ),
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute( builder: (context) => const SignUp() ),
                                  );
                                },
                                child: const Text("SignUp", style:  TextStyle( color: Colors.black ))
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ),
              ],
            )
        ),
      ),
    );
  }
}
