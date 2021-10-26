import 'package:flutter/material.dart';
import 'package:trapp_flutter/Widget/circle.dart';
import 'package:trapp_flutter/screens/authentication/sign_in.dart';
import 'package:trapp_flutter/screens/authentication/sign_up_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/imgHome.jpeg'),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _content(context),
      ),
    );
  }

  Widget _content(context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  height: 15,
                ),
                Container(
                    padding: const EdgeInsets.all(34),
                    height: 500,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            spreadRadius: 3,
                            blurRadius: 10,
                          )
                        ]),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Positioned(
                            child: Circulo(
                              size: 200,
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SignIn(toggleView: () {
                                            // Navigator.pop(context);
                                          })),
                                );
                              },
                              color: const Color(0xff00AFB9),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: const Center(
                                  child: Text(
                                'Sign In',
                                style: TextStyle(color: Color(0xffF3F9E3)),
                              ))),
                          const SizedBox(
                            height: 0.9,
                          ),
                          RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp()),
                                );
                              },
                              color: const Color(0xffEDD83D),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: const Center(
                                  child: Text(
                                'Sign Up',
                                style: TextStyle(color: Color(0xff481620)),
                              )))
                        ]))
              ])),
    );
  }
}
