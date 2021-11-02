import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/imgSignIn.jpeg"),
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
                            Text(
                                'Welcome',
                              style: TextStyle(
                                fontFamily: 'thaBold',
                                fontSize: MediaQuery.of(context).size.width / 7,
                                color: const Color(0xff7B767D),
                              ),
                            ),
                            Neumorphic(
                              style: const NeumorphicStyle(depth: -8),
                              child: SizedBox(
                                height: 50,
                                width: 400,
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      // keyWordFilter = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      // border: OutlineInputBorder(),
                                      // contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      icon: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 0, 0, 0),
                                          child: Icon(Icons.email)),
                                      hintText: 'Email',
                                  ),
                                ),
                              ),
                            ),
                            Neumorphic(
                              style: const NeumorphicStyle(depth: -8),
                              child: SizedBox(
                                height: 50,
                                width: 400,
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      // keyWordFilter = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    // border: OutlineInputBorder(),
                                    // contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                    icon: Padding(
                                        padding:
                                        EdgeInsets.fromLTRB(15, 0, 0, 0),
                                        child: Icon(Icons.password)),
                                    hintText: 'Password',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 350,
                              height: 45,
                              child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color(0xffEDD83D)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ))),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Container()),
                                    );
                                  },
                                  child: const Text("SignUp",
                                      style: TextStyle(color: Colors.black))),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            )),
      ),
    );
  }
}
